from confluent_kafka import Consumer, KafkaException
import hashlib
import json
import pandas as pd
from sqlalchemy import create_engine
from datetime import datetime, timedelta

# Настройка подключения к базе данных
db_connection = create_engine('postgresql://username:password@localhost:5432/postgres')

# Утилита для создания хэшей
def create_hash(value):
    if isinstance(value, (list, tuple)):
        value = ''.join(map(str, value))
    return hashlib.sha256(str(value).encode()).hexdigest()

# Подготовка данных для хаба
def prepare_hub_data(new_record, config):
    return {
        config["pk"]["as"]: [create_hash(new_record[config["pk"]["from"]])],
        config["id"]["as"]: [new_record[config["id"]["from"]]],
        config["load_date"]["as"]: [datetime.utcnow().date()],
        config["record_source"]["as"]: [config["record_source"]["from"]]
    }

# Подготовка данных для сателлита
def prepare_sat_data(new_record, config):
    sat_hash = create_hash([new_record[field] for field in config["hashdiff"]["from"]])
    sat_data = {
        config["pk"]["as"]: [create_hash(new_record[config["pk"]["from"]])],
        config["hashdiff"]["as"]: [sat_hash],
        config["start_time"]["as"]: [resolve_macros(new_record, config["start_time"]["from"])],
        config["load_date"]["as"]: [datetime.utcnow().date()],
        config["record_source"]["as"]: [config["record_source"]["from"]]
    }
    for column, source in config["adds"].items():
        sat_data[column] = [resolve_macros(new_record, source)]
    return sat_data

# Подготовка данных для линков
def prepare_link_data(new_record, link_config, global_config):
    left_hash = create_hash(new_record[link_config["left_pk"]["from"]])
    right_hash = create_hash(new_record[link_config["right_pk"]["from"]])
    link_data = {
        link_config["pk"]["as"]: [create_hash([left_hash, right_hash])],
        link_config["left_pk"]["as"]: [left_hash],
        link_config["right_pk"]["as"]: [right_hash],
        global_config["load_date"]["as"]: [datetime.utcnow().date()],
        global_config["record_source"]["as"]: [global_config["record_source"]["from"]]
    }
    return link_data

# Разрешение макросов
def resolve_macros(data, field):
    if "#" in field:
        parts = field.split("#")
        if len(parts) == 2:
            return datetime(1970, 1, 1) + timedelta(seconds=data.get(parts[1], 0))
        elif len(parts) == 3 and parts[1].isdigit():
            divisor = int(parts[1])
            return datetime.fromtimestamp(data.get(parts[0], 0) // divisor)
    return data.get(field)

# Функция обработки записей
def process_record(old_record, new_record, entity_config, schema_name):
    # Хаб
    if "hub" in entity_config and old_record is None:
        hub_data = prepare_hub_data(new_record, entity_config["hub"])
        pd.DataFrame(hub_data).to_sql(
            entity_config["hub"]["table"], 
            db_connection, 
            schema=schema_name, 
            index=False, 
            if_exists="append"
        )
    
    # Сателлит
    if "sat" in entity_config:
        sat_data = prepare_sat_data(new_record, entity_config["sat"])
        pd.DataFrame(sat_data).to_sql(
            entity_config["sat"]["table"], 
            db_connection, 
            schema=schema_name, 
            index=False, 
            if_exists="append"
        )

    # Линки
    if "link" in entity_config and old_record is None:
        for link_config in entity_config["link"]:
            link_data = prepare_link_data(new_record, link_config, entity_config)
            pd.DataFrame(link_data).to_sql(
                link_config["table"], 
                db_connection, 
                schema=schema_name, 
                index=False, 
                if_exists="append"
            )
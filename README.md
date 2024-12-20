## Авторы
1. **Имайкин Егор Евгеньевич**, [im_egorrrr](https://t.me/im_egorrrr)
2. **Лебедев Никита Александрович**, [nikit_lebedev](https://t.me/nikit_lebedev)
3. **Труфанов Дмитрий Михайлович**, [dimi3_tru](https://t.me/dimi3_tru)
4. **Смирнов Арсений Сергеевич**, [ars_kko](https://t.me/ars_kko)

Группа мФТиАД231

## Как запустить проект

Клонирование проекта из этого репо:
```
git clone https://github.com/DOMENTOR/DWH_hw02
```
Запуск инициализации БД:
```
docker-compose up --build
```
Параметры для подключения:
Мастер
```
psql -h 127.0.0.1 -p 5432 -U postgres -d postgres
```
Слейв:
```
psql -h 127.0.0.1 -p 5433 -U postgres -d postgres
```
DWH:
```
psql -h 127.0.0.1 -p 5434 -U postgres -d postgres
```

Debezium:
```
debezium/commands.sh
```

## Результаты:

![alt text](image.png)

![alt text](image-1.png)

![alt text](image-2.png)

![alt text](image-3.png)

![alt text](image-4.png)

![image_2024-12-10_23-35-56](https://github.com/user-attachments/assets/6da68a12-2e69-4396-a34a-f65e240a9c67)

![image_2024-12-10_23-36-50](https://github.com/user-attachments/assets/44a6a849-0341-46be-abaa-46b46d1a8685)

```
dbt run -m tag:raw
```
![image_2024-12-10_23-38-53](https://github.com/user-attachments/assets/690890fd-25f8-40d8-9668-82bb09f740bc)

```
dbt run -m tag:stage
```
![image_2024-12-10_23-41-16](https://github.com/user-attachments/assets/3d76b8a7-70a2-4672-be7c-a4df24aabb03)

```
dbt run -m tag:hub
```
![image_2024-12-11_00-07-49](https://github.com/user-attachments/assets/b9c88163-199c-4c1b-92ef-493b3b7ecc2c)



#### Директория: DWH_hw02-main
Команда:
```
docker-compose up -d
```
Перед запуском нужно удалить data, data-slave.
![alt text](image-10.png)

#### Директория: DWH_hw02-main\dbt_dwh
Команды:
```
dbt run -m tag:raw
dbt run -m tag:stage
dbt run -m tag:hub
dbt run -m tag:links
dbt run -m tag:satellite
```

Опционально (если папка DWH_hw02-main\dbt_dwh\dbt_packages\automate_dv пуста):
```
dbt deps
```

![alt text](image-6.png)
![alt text](image-7.png)
![alt text](image-8.png)
![alt text](image-9.png)


#### Директория: DWH_hw02-main\debezium
Команды (Linux-like):
```
chmod +x commands.sh

./commands.sh
```

Команды (Windows PowerShell):
```
Invoke-WebRequest -Uri "http://localhost:8083/connectors" -Method POST -Headers @{ "Content-Type" = "application/json"; "Accept" = "application/json" } -Body (Get-Content -Raw "debezium.json")

Invoke-WebRequest -Uri "http://localhost:8082/consumers/dwh_group" -Method POST -Headers @{ "Content-Type" = "application/vnd.kafka.v2+json"; "Accept" = "application/vnd.kafka.v2+json" } -Body '{"name": "dwh_group", "format": "binary", "auto.offset.reset": "latest"}'

python add_sink_connectors.py
```

![alt text](image-5.png)

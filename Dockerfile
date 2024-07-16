# Используем базовый образ нашей астры 1.7.5
FROM astra:1.7.5.9-pip

# Установим Python и pip
RUN apt update && apt install -y python3 python3-pip

# Установим Flask
RUN pip3 install flask

# Скопируем наше Flask приложение в контейнер
COPY app.py /app/app.py

# Установим рабочую директорию
WORKDIR /app

# Откроем порт 5000 для Flask
EXPOSE 5000

# Запустим Flask приложение
CMD ["python3", "app.py"]

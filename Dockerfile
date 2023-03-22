FROM python:3.10-alpine

WORKDIR /app

COPY ./requirements.txt .

RUN apk update

RUN pip install -r requirements.txt

COPY . .

EXPOSE 5000

CMD gunicorn --bind 0.0.0.0:5000 -w 4 run:app
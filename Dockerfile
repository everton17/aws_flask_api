FROM python:3.10-alpine

ARG ACCESS_KEY
ARG SECRET_KEY
ENV AWS_ACCESS_KEY_ID $ACCESS_KEY
ENV AWS_SECRET_ACCESS_KEY $SECRET_KEY

WORKDIR /app

COPY ./requirements.txt .

RUN apk update

RUN pip install -r requirements.txt

COPY . .

EXPOSE 5000

CMD gunicorn --bind 0.0.0.0:5000 -w 4 run:app
# pull official base image
FROM python:3.7.4-alpine

# set working directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# set environment varibles
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# add and install requirements
COPY ./Pipfile.lock .
COPY ./Pipfile  .
RUN pip install --upgrade pip
RUN pip install pipenv && pipenv install --system

# add app
COPY . .

# run server
CMD python manage.py run -h 0.0.0.0

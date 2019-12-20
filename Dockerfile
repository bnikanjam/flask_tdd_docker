# pull official base image
FROM python:3.7.4-alpine

# install dependencies
RUN apk update && \
    apk add --virtual build-deps gcc python-dev musl-dev && \
    apk add postgresql-dev && \
    apk add netcat-openbsd

# set working directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# set environment varibles
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install app's dependencies with Pipenv including development tools
COPY ./Pipfile.lock .
COPY ./Pipfile  .
RUN pip install --upgrade pip
RUN pip install pipenv
RUN pipenv install --system
RUN pipenv install --system --dev


# Add entrypoint.sh
COPY ./entrypoint.sh /usr/src/app/entrypoint.sh
RUN chmod +x /usr/src/app/entrypoint.sh

# Add app
COPY . /usr/src/app

# Run flask development server
CMD python manage.py run -h 0.0.0.0

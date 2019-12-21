#!/bin/sh

docker-compose exec users pytest "project/tests" -p no:warnings --cov="project"

docker-compose exec users flake8 project
docker-compose exec users black project
docker-compose exec users /bin/sh -c "isort project/*/*.py"

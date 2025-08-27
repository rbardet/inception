DOCKER_COMPOSE = srcs/docker-compose.yml

up:
	sudo docker compose -f ${DOCKER_COMPOSE} up --build
down:
	sudo docker compose -f ${DOCKER_COMPOSE} down
start:
	sudo docker compose -f ${DOCKER_COMPOSE} up

PHONY: up down start
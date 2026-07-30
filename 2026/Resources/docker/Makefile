SHELL := /bin/sh

COMPOSE := docker compose
APP := $(COMPOSE) exec app
COMPOSER := $(APP) composer
ARTISAN := $(APP) php artisan

.DEFAULT_GOAL := help

.PHONY: help build up start stop down restart ps logs app-logs mysql-logs \
        shell mysql-shell install update key migrate migrate-fresh seed \
        test test-unit test-feature clear optimise permissions pull push \
        config validate clean reset

help:
	@echo "Laravel + MySQL Docker commands"
	@echo ""
	@echo "  make build          Build the Laravel PHP image"
	@echo "  make up             Start containers in the background"
	@echo "  make stop           Stop containers"
	@echo "  make down           Stop and remove containers"
	@echo "  make restart        Restart the stack"
	@echo "  make logs           Follow all container logs"
	@echo "  make shell          Open a shell in the PHP container"
	@echo "  make mysql-shell    Open the MySQL client"
	@echo "  make install        Install Composer dependencies"
	@echo "  make key            Generate the Laravel application key"
	@echo "  make migrate        Run Laravel migrations"
	@echo "  make seed           Run database seeders"
	@echo "  make test           Run the Laravel test suite"
	@echo "  make clear          Clear Laravel caches"
	@echo "  make validate       Validate the Compose file"
	@echo "  make reset          Remove containers and MySQL data"

build:
	$(COMPOSE) build --pull

up:
	$(COMPOSE) up -d --build

start:
	$(COMPOSE) start

stop:
	$(COMPOSE) stop

down:
	$(COMPOSE) down

restart:
	$(COMPOSE) down
	$(COMPOSE) up -d

ps:
	$(COMPOSE) ps

logs:
	$(COMPOSE) logs -f

app-logs:
	$(COMPOSE) logs -f app

mysql-logs:
	$(COMPOSE) logs -f mysql

shell:
	$(APP) sh

mysql-shell:
	$(COMPOSE) exec mysql mysql \
		-u"$${MYSQL_USER:-laravel}" \
		-p"$${MYSQL_PASSWORD:-development-password}" \
		"$${MYSQL_DATABASE:-laravel}"

install:
	$(COMPOSER) install

update:
	$(COMPOSER) update

key:
	$(ARTISAN) key:generate

migrate:
	$(ARTISAN) migrate

migrate-fresh:
	$(ARTISAN) migrate:fresh --seed

seed:
	$(ARTISAN) db:seed

test:
	$(ARTISAN) test

test-unit:
	$(ARTISAN) test --testsuite=Unit

test-feature:
	$(ARTISAN) test --testsuite=Feature

clear:
	$(ARTISAN) optimize:clear

optimise:
	$(ARTISAN) optimize

permissions:
	$(APP) sh -c 'chown -R www-data:www-data storage bootstrap/cache && chmod -R ug+rwX storage bootstrap/cache'

pull:
	$(COMPOSE) pull

push:
	docker push ghcr.io/REPLACE_WITH_COLLEGE_ORG/laravel-php-mysql:8.4-bookworm-v1

config:
	$(COMPOSE) config

validate:
	$(COMPOSE) config --quiet

clean:
	$(COMPOSE) down --remove-orphans
	docker image prune -f

reset:
	$(COMPOSE) down --volumes --remove-orphans

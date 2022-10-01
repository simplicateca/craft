# Determine the docker compose API version to get the separator character
VERSION?=$(shell docker-compose -v)
ifneq (,$(findstring v2.,$(VERSION)))
	SEPARATOR:=-
else
	SEPARATOR:=_
endif
CONTAINER?=$(shell basename $(CURDIR)| tr A-Z a-z)$(SEPARATOR)php$(SEPARATOR)1
DBCONTAINER?=$(shell basename $(CURDIR)| tr A-Z a-z)$(SEPARATOR)mysql$(SEPARATOR)1
BUILDCHAIN?=$(shell basename $(CURDIR)| tr A-Z a-z)$(SEPARATOR)webpack$(SEPARATOR)1

.PHONY: build clean composer craft dev npm fixdb pulldb restoredb nuke ssh sshroot up

build: up
	docker exec -it $(BUILDCHAIN) npm run build
clean:
	rm -f cms/composer.lock
	rm -rf cms/vendor/
	rm -f buildchain/package-lock.json
	rm -rf buildchain/node_modules/
	chmod 0777 cms/.env; \
	chmod 0777 cms/composer.json; \
	chmod 0777 cms/config; \
	chmod -f 0777 cms/composer.lock || true; \
	chmod -f 0777 cms/config/license.key || true; \
	chmod -R 0777 cms/config/project; \
	chmod -R 0777 cms/storage; \
	chmod -R 0777 cms/web/cpresources;
composer: up
	docker exec -it $(CONTAINER) su-exec www-data composer \
		$(filter-out $@,$(MAKECMDGOALS))
craft: up
	docker exec -it $(CONTAINER) su-exec www-data php craft \
		$(filter-out $@,$(MAKECMDGOALS))
dev: up
npm: up
	docker exec -it $(BUILDCHAIN) npm \
		$(filter-out $@,$(MAKECMDGOALS))
fixdb: up
	docker exec -it $(DBCONTAINER) mysql -uroot -psecret -Bse "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';ALTER USER 'project'@'%' IDENTIFIED WITH mysql_native_password BY 'project';"
pulldb: up
	cd scripts/ && ./docker_pull_db.sh
restoredb: up
	cd scripts/ && ./docker_restore_db.sh \
		$(filter-out $@,$(MAKECMDGOALS))
nuke: clean
	docker-compose down -v
	docker-compose up --build --force-recreate
ssh: up
	docker exec -it $(CONTAINER) su-exec www-data /bin/sh
sshroot: up
	docker exec -it $(CONTAINER) su-exec www-data /bin/sh	


up:
	if [ ! "$$(docker ps -q -f name=$(CONTAINER))" ]; then \
		cp -n cms/.env.example cms/.env; \
		docker-compose up; \
    fi
%:
	@:
# ref: https://stackoverflow.com/questions/6273608/how-to-pass-argument-to-makefile-from-command-line
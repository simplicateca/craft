CONTAINER?=$(shell basename $(CURDIR)| tr A-Z a-z)_php_1
DBCONTAINER?=$(shell basename $(CURDIR)| tr A-Z a-z)_mysql_1
BUILDCHAIN?=$(shell basename $(CURDIR)| tr A-Z a-z)_webpack_1

.PHONY: build clean composer craft dev npm fixdb pulldb restoredb nuke ssh update update-clean up

build: up
	docker exec -it ${BUILDCHAIN} npm run build
clean:
	docker-compose down -v
	docker-compose up --build
composer: up
	docker exec -it ${CONTAINER} composer \
		$(filter-out $@,$(MAKECMDGOALS))
craft: up
	docker exec -it ${CONTAINER} php craft \
		$(filter-out $@,$(MAKECMDGOALS))
dev: up
npm: up
	docker exec -it ${BUILDCHAIN} npm \
		$(filter-out $@,$(MAKECMDGOALS))
fixdb: up
	docker exec -it ${DBCONTAINER} mysql -uroot -psecret -Bse "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';ALTER USER 'project'@'%' IDENTIFIED WITH mysql_native_password BY 'project';"
pulldb: up
	cd scripts/ && ./docker_pull_db.sh
restoredb: up
	cd scripts/ && ./docker_restore_db.sh \
		$(filter-out $@,$(MAKECMDGOALS))
nuke:
	docker-compose down -v
	rm -f cms/composer.lock
	rm -rf cms/vendor/
	docker-compose up --build --force-recreate
ssh: up
	docker exec -it ${CONTAINER} /bin/sh
update:
	docker-compose down
	rm -f cms/composer.lock
	rm -f buildchain/package-lock.json
	docker-compose up
update-clean:
	docker-compose down
	rm -f cms/composer.lock
	rm -rf cms/vendor/
	rm -f buildchain/package-lock.json
	rm -rf buildchain/node_modules/
	docker-compose up
up:
	if [ ! "$$(docker ps -q -f name=${CONTAINER})" ]; then \
		cp -n cms/.env.example cms/.env; \
      	chmod 0777 cms/.env; \
      	chmod 0777 cms/composer.json; \
      	chmod -f 0777 cms/composer.lock || true; \
      	chmod 0777 cms/config; \
      	chmod -R 0777 cms/config/project; \
      	chmod -f 0777 cms/config/license.key || true; \
      	chmod -R 0777 cms/storage; \
      	chmod -R 0777 cms/vendor; \
      	chmod -R 0777 cms/web/cpresources; \
		docker-compose up; \
    fi
%:
	@:
# ref: https://stackoverflow.com/questions/6273608/how-to-pass-argument-to-makefile-from-command-line
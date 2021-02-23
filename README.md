# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

#USEFUL COMMANDS\
docker-compose build web\
docker-compose run web bundle install\
docker-compose run web yarn install\
docker-compose build web\
docker-compose up --detach db\
docker-compose ps\
docker-compose run web rails db:create\
docker-compose run web rails db:migrate\
docker-compose run web rails db:seed\

sudo docker exec -it therealbboe_db_1 /bin/bash \
Psql -U postgres app_development\




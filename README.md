# Simple REST API, built for Goodrequest Fitness APP

Steps to run this project:

1. Run `npm i` command
2. Setup database settings inside `ormconfig.json` file
3. Run `npm start` command TypeORM will take care about DB structure init.

4. (optional) ADMIN USER MIGRATION for start without SQL import: npm run migration:run

Steps to setup database:

sudo -u postgres psql
postgres=# create database goodrequest;
postgres=# create user goodrequest with encrypted password 'goodrequest';
postgres=# grant all privileges on database goodrequest to goodrequest;

SQL Dump provided

u: admin p: admin
u: user  p: user


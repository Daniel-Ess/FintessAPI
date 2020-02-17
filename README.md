# Simple REST API, built for Goodrequest Fitness APP

Steps to run this project:

1. Run `npm i` command
2. Setup database settings inside `ormconfig.json` file
3. Run `npm start` command TypeORM will take care about DB structure init.

4. (optional) ADMIN & USER MIGRATION for start without SQL import: `npm run migration:run`

Steps to setup database:

1. `sudo -u postgres psql`
2. postgres=# `create database goodrequest;`
3. postgres=# `create user goodrequest with encrypted password 'goodrequest';`
4. postgres=# `grant all privileges on database goodrequest to goodrequest;`

SQL Dump provided

1. u: admin p: admin
2. u: user  p: user


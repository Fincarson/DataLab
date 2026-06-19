# GraphQL Backend Adventure
[建置教學](https://docs.google.com/presentation/d/1ZIf877yCXrQ0aW6Se3_AIq38iU9FsjXpBE6JEn4RiIE/edit?usp=sharing)
## Install
```bash
$ yarn install
```

## Create environment
Environment file example.
```
# .env
# Apollo Server
VERSION=1.0.0
NODE_ENV=development
PORT=3000
SECRET=YOUR_SECRET

# Database
DB_HOST=127.0.0.1
DB_PORT=3306
DB_NAME=gql
DB_USER=root
DB_PASS=
```
## Getting Started
### Run Server
```bash
$ yarn dev
```

### Test

```bash
$ yarn test
```
or
#### Standard
https://standardjs.com/
```bash
yarn standard --fix
```

#### Jest
https://jestjs.io/

https://jestjs.io/docs/expect

https://pjchender.dev/npm/npm-jest/
```bash
yarn jest
```

Jest config
```
  "jest": {
    "verbose": true,
    "collectCoverage": true
  },
```
## MySql
https://dev.mysql.com/downloads/mysql/

## Dcoker Mysql
https://youtu.be/kphq2TsVRIs
### Step1. Run Docker Image
如果你想要換 port 的話你可以修改 3306:3306 改成 33066:3306，那麼你的 port 就會改到 33066。

```bash
$ docker run --name some-mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=1234 -d mysql
```

### Step2. Image CLI - MySql
```bash
$ docker exec -it container_id /bin/sh
```

```bash
$ mysql -p
```

###  Step3. Creating and Selecting a Database
https://dev.mysql.com/doc/refman/8.0/en/database-use.html
#### Creating database
```sql
mysql> CREATE DATABASE menagerie;
```

#### Check 

```sql
mysql> SHOW DATABASES;
```


#### Selecting database
```sql
mysql> USE menagerie;
```

#### Creating table
```sql
mysql> CREATE TABLE User (
    userId INT AUTO_INCREMENT PRIMARY KEY,
    userName VARCHAR(255) NOT NULL,
    userOrder VARCHAR(255) NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

#### List table
```sql
mysql> SHOW TABLES;
```

#### List User table
```sql
mysql> SELECT * FROM User;
```

## Docker 
### Stop Docker Image
```bash
$ docker stop some-mysql
```

### Remove Docker Image
```bash
$ docker rmi some-mysql
```
### List Docker Container Id
```bash
$ docker ps
```

### Open image CLI

```bash
$ docker exec -it container_id /bin/sh
```
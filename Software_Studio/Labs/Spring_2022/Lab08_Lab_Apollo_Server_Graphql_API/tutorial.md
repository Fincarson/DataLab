## 前言
### Apollo Server 
一個易於使用、高度可擴展的開源框架，用於將服務和數據源連接到圖形。

優點：
- 成熟的社群
- Query 執行狀況和紀錄
- 效能追蹤


### GraphQL
[GraphQL](https://graphql.org/learn/) 是一種 API 的查詢語言。且在的 API 中的數據提供了完整且易於理解的描述，使開發者能夠準確詢問他們需要什麼。

優點：
- 資料只拿剛好且彈性十足
- 透過資料之間的關係連接 ，大幅減少來回 request 的次數
- 前後端溝通成本減少
- 前端不再被架構設計綁住，加速開發

<!-- more -->


## 準備
在開始之前請確保已經安裝[Node.js](https://nodejs.org/en/download/)。

[下載完整程式碼](https://github.com/Daviswww/graphQL-backend-adventure/tree/part1)

## Yarn
Yarn 是一個套件管理工具，提供的功能面向來說，和大家常用的 npm 是差不多的，而 Yarn 擁有更快速度、更安全、更可靠的環境。

- 速度
NPM 將一次安裝一個套件。它每次都只能下載一個套件。這意味著，如果安裝包含五個包的清單，NPM 將執行很多次安裝過程。

- 安全
	過去 NPM 非常脆弱，無法提供安全的安裝過程。這允許其他套件動態包含其他套件，從而導致可能的安全系統漏洞。

	Yarn 在幕後進行檢查，確保你沒有下載腳本或可能與專案依賴項衝突的內容。安全性是Yarn的核心功能之一。

### 安裝
https://classic.yarnpkg.com/lang/en/docs/install/

在終端機或命令提示字元中執行以下指令：
```bash
$ npm install --global yarn
```

檢查是否有安裝成功：
```bash
$ yarn --version
```

### 常用指令
- 安裝
```
yarn install
```
- 新增套件
```
yarn add [package]
```
- 移除套件
```
yarn remove [package]
```


## Apollo Server Implement
### 下載

專案下載：
``
```

用終端機進去資料夾中輸入下面的指令：
```bash
$ yarn install
```

### 資料夾架構
以下是資料夾結構，往後會按照這個架構來完成我們的伺服器。
```
.
├── README.md
├── app.js
├── config
│   └── environment
│       └── index.js
├── graphql
│   ├── index.js
│   ├── resolvers
│   │   ├── index.js
│   │   └── version
│   │       ├── index.js
│   │       └── queries.js
│   ├── typedefs
│   │   └── index.graphql
│   └── utils
│       └── schema.js
├── index.js
├── package.json
└── yarn.lock
```

### 環境變數
#### 1. 設定環境變數
創建一個`.env`檔案設定環境變數，我們可以在這個檔案內設置一些專案的秘密變數，像是`SECRET_KEY`, `DATABASE`等等這類的變數，再往後使用`git`的時候可以把這個檔案忽略掉，就可以避免這些`KEY`外流。

```
# Apollo Server
VERSION=1.0.0
NODE_ENV=development
PORT=3000
SECRET=sxdWEF123hcf323jFWgvF763WEykhbljdrW1EFutyiuo87yuiWFWEhj
```

#### 2. 讀取環境變數
設定完環境變數後我們將可透過`dotenv`這個套件讀取設定好得值，接著再透過`config/environment/index.js`讀取這些變數，提供專案使用。

```javascript
import dotenv from 'dotenv'

dotenv.config()

const port = process.env.PORT
const secret = process.env.SECRET
const version = process.env.VERSION

// Different situations
const env = {
  development: process.env.NODE_ENV === 'development',
  test: process.env.NODE_ENV === 'test',
  staging: process.env.NODE_ENV === 'staging',
  production: process.env.NODE_ENV === 'production'
}

// Database
const db = {
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  name: process.env.DB_NAME,
  port: process.env.DB_PORT
}

export { port, env, secret, db, version }

```

### Apollo Server

首先先從根目錄的`/index.js`開始，在這邊我們使用的是`apollo-server-express`來建構我們的 Apollo Server。

#### 1. 設置伺服器
`/app.js` 將為我們應用程式創建一個擁有有效的HTTP伺服器。

```javascript
import express from 'express'
import { createServer } from 'http'
	
const app = express()
const httpServer = createServer(app)

export { httpServer, app }
```
#### 2. 設置架構內容
`graphql/index.js` 在這邊我們將設置我們伺服器的內容，像是GrahpQL 中的 [schema](https://graphql.org/learn/schema/)、伺服器的密鑰、開發環境等等...。

```javascript
import { ApolloServer } from 'apollo-server-express'
import { env, secret } from '../config/environment'
import schema from './utils/schema'

const apolloServer = new ApolloServer({
  schema,
  secret: secret,
  playground: env.development,
})

export default apolloServer


```

### Schema

我們可以從[Apollo的官方文件]((https://www.apollographql.com/docs/apollo-server/getting-started/#step-3-define-your-graphql-schema))中看見 Schema 分為兩個部分：
- Typedefs: 數據的型態
- Resolvers: 計算和返回數據的方式

#### 1. Type System
Typedefs 就是 Graphql 查詢 API 的一種表達方式，在這之中有三種操作的名稱分別為：

- Query: 取得資料
- Mutation: 修改資料
- Subscription: 訂閱資料

針對不同的操作我們可以將物件分類在這三個類別內。


你可以在`graphql/typedefs/index.graphql`這個檔案中定義 GraphQL 的物件型態，像是下面我就定義了`version: String!`，驚嘆號則是代表這個物件不能是空的，如果是空的則會報錯。

GraphQL 的型態分成五個：
- Int：有符號 32 位整數。
- Float：有符號雙精度浮點值。
- String：UTF‐8 字元序列。
- Boolean：true 或 false
- ID：ID 標量類型表示唯一標識符，通常用於重新引用對象或作為緩存的鍵。

```graphql
# Custom Scalars
scalar Date

type Query {
  # Version
  version: String!
  
}

type Mutation {
    
}

type Subscription {

}
```




#### 2. Resolvers
Resolvers 則是處理邏輯然後回傳與Typedefs個是相同的資料。
可以從`graphql/resolvers/version/queries.js`，設定回傳內容。

```javascript
import { version } from '../../../config/environment'

const versionQueries = {
  version: async () => {
    return version
  }
}

export default versionQueries

```

再透過`graphql/resolvers/index.js`將我們回傳的資料放入`Query`然後展開。

```javascript
import { versionQueries } from './version'

const resolvers = {
  Query: {
    ...versionQueries,
  }
}

export default resolvers
```

#### 3. 合併成 Schema
完成Resolvers和Typedefs之後，可以透過`graphql/utils/schema.js`將我們所設置的內容合併成Schema。

```javascript
import { join } from 'path'
import { readdirSync, readFileSync } from 'fs'
import { makeExecutableSchema } from '@graphql-tools/schema'
import { gql } from 'apollo-server-core'
import resolvers from '../resolvers'

const gqlFiles = readdirSync(join(__dirname, '../typedefs'))

let typeDefsString = ''

gqlFiles.forEach((file) => {
  typeDefsString += readFileSync(join(__dirname, '../typedefs', file), {
    encoding: 'utf8'
  })
})

const typeDefs = gql(typeDefsString)

const schema = makeExecutableSchema({
  typeDefs,
  resolvers
})

export default schema

```

### 初始化應用程式
最後再到`/index.js`啟動我們的伺服器，並初始化所有內容。


執行下面指令將可以看到你所設置的API：
```bash
$ yarn dev
```


```javascript
import { httpServer, app } from './app'
import { port } from './config/environment'
import graphqlServer from './graphql'

const main = async () => {
  try {    
    // Apollo Server
    await graphqlServer.start()
    graphqlServer.applyMiddleware({ app, path: '/graphql' })

    httpServer.listen(port, () => {
      console.log(`Server is now running on http://localhost:${port}/graphql`)
    })
  } catch (err) {
    console.log('Not able to run GraphQL server !')
    console.log(err)
  }
}

main()

```

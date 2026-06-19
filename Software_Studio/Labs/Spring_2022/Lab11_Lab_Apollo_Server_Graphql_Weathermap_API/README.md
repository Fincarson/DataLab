# Lab Apollo Server Graphql Weathermap Api
[建置流程](https://docs.google.com/presentation/d/1nDaYChOJX7PAbMreHEoo22cS9mGnDC1_pcTE7_zmUPk/edit?usp=sharing)
## Install
```bash
$ yarn install
```

## Get WeatherMapApi Key
https://openweathermap.org/api
## Create environment
Environment file example.
```
# .env
VERSION=1.0.0
NODE_ENV=development
PORT=3000
SECRET=

# API
API_HOST=api.openweathermap.org/data/2.5/
API_KEY=

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
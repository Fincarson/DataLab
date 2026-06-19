import { HTTPCache, RESTDataSource } from 'apollo-datasource-rest'
import { api } from '../config/environment'

class WeathermapAPI extends RESTDataSource {
  constructor () {
    super()
    this.baseURL = `https://${api.host}`
    this.httpCache = new HTTPCache()
  }

  async getWeather ({ country }) {
    const response = await this.get('find', { q: country, appid: api.key })
    return response
  }
}

export default WeathermapAPI

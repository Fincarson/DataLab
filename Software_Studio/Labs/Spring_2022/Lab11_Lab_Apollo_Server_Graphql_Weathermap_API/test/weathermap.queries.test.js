import { createTestClient } from 'apollo-server-testing'
import { gql } from 'apollo-server'
import graphqlServer from '../graphql'
import WeathermapAPI from '../models/weathermapDataSource'

const GET_COUNTRY_WEATHER = gql`
query Query($country: String!) {
  weather(country: $country) {
    message
    cod
    count
    list {
      id
      name
      dt
      rain
      snow
      weather {
        id
        main
        description
        icon
      }
      clouds {
        all
      }
      sys {
        country
      }
      wind {
        speed
        deg
      }
      main {
        temp
        feels_like
        temp_min
        temp_max
        pressure
        humidity
      }
      coord {
        lat
        lon
      }
    }
  }
}
`

const _country = 'Hawaii'
const _weathermapAPI = new WeathermapAPI()

describe('[Queries.WeatherMapAPI]', () => {
  it('Access current weather data for any location', async () => {
    const data = await _weathermapAPI.getWeather({ country: _country })
    const { query } = createTestClient(graphqlServer)

    const res = await query({
      query: GET_COUNTRY_WEATHER,
      variables: { country: _country }
    })

    expect(res.data.weather).toMatchObject(data)
  })
})

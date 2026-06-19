import WeathermapAPI from '../models/weathermapDataSource'

const schema = {
  message: expect.any(String),
  cod: expect.any(String),
  count: expect.any(Number),
  list: expect.any(Array)
}

const _country = 'Hawaii'
const _weathermapAPI = new WeathermapAPI()

describe('[Weathermap.datasource]', () => {
  it('Current Weather Data Model', async () => {
    const data = await _weathermapAPI.getWeather({ country: _country })

    // Check Type
    expect(data).toMatchObject(schema)
    expect(data.cod).toBe('200')
    expect(data.count).not.toBe(0)
  })
})

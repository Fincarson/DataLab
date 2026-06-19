const weatherQueries = {
  weather: async (_, args, { dataSources }) => {
    return await dataSources.weatherAPI.getWeather({ country: args.country })
  }
}

export default weatherQueries

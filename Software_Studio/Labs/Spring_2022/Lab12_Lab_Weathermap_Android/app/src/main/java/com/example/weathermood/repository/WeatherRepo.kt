package com.example.weathermood.repository

import com.example.weathermood.usecase.GraphqlUsecase

class WeatherRepo {

  // Variable Section
  private val graphqlUsecase = GraphqlUsecase()

  suspend fun getCountryTodayWeather(country: String): String = graphqlUsecase.getCountryTodayWeather(country)
}
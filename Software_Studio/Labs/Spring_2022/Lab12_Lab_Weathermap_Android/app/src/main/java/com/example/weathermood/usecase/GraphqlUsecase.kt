package com.example.weathermood.usecase

import android.util.Log
import com.apollographql.apollo3.ApolloClient
import com.example.weathermood.Query
import com.example.weathermood.WeatherQuery
import com.example.weathermood.type.Weather
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

class GraphqlUsecase {
    suspend fun getCountryTodayWeather(country: String): String {
        return withContext(Dispatchers.IO) {
            Log.d("GraphQL", "getCountryTodayWeather: $country")
            try {
                val apolloClient = ApolloClient.Builder()
                    .serverUrl("http://10.0.2.2:3000/graphql")
                    .build()
                // Execute your query. This will suspend until the response is received.
                val response = apolloClient.query(WeatherQuery(country = country)).execute()
                println("Hero.name=${response.data?.weather?.list?.get(0)?.weather?.get(0)?.description}")

                return@withContext response.data?.weather?.list?.get(0)?.weather?.get(0)?.description.toString()
            } catch (e: Exception) {
                System.out.println("Error " + e.message);
            }
        }.toString()
    }
}
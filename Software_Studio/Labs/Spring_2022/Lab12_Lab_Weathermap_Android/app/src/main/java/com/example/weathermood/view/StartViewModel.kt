package com.example.weathermood.view

import android.util.Log
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.weathermood.repository.WeatherRepo
import kotlinx.coroutines.launch

private val TAG = "StartViewModel"

class StartViewModel : ViewModel() {
  private val weatherRepo = WeatherRepo()

  // Test Code Section
  private val _currentWeather = MutableLiveData("NULL")
  val currentWeather = _currentWeather

  // End section


  private val _weatherDescription = MutableLiveData("Sunny")
  val weatherDescription: LiveData<String> = _weatherDescription

  private val _city = MutableLiveData("City")
  val city: LiveData<String> = _city

  fun getCountryTodayWeather(country: String = "Hsinchu") {
    viewModelScope.launch {
      _currentWeather.value = "Loading"
      Log.d(TAG, "getCountryTodayWeather is called")
      _currentWeather.value = weatherRepo.getCountryTodayWeather(country)
    }

  }
}
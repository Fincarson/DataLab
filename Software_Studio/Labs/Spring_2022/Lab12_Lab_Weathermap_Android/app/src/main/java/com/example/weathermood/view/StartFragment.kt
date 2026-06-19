package com.example.weathermood.view

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import com.example.weathermood.databinding.FragmentStartBinding

class StartFragment : Fragment() {

  private var binding: FragmentStartBinding? = null
  private val startViewModel: StartViewModel by activityViewModels()

  override fun onCreateView(
    inflater: LayoutInflater, container: ViewGroup?,
    savedInstanceState: Bundle?
  ): View? {
    val fragmentBinding = FragmentStartBinding.inflate(inflater, container, false)
    binding = fragmentBinding
    return fragmentBinding.root
  }

  override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
    super.onViewCreated(view, savedInstanceState)
    binding?.apply {
      lifecycleOwner = viewLifecycleOwner
      startFragment = this@StartFragment
      viewModel = startViewModel

      buttonGetCountryWeather.setOnClickListener{
        Log.d("GraphQL", "${edittextCountry.text.toString()}")
        startViewModel.getCountryTodayWeather(edittextCountry.text.toString())
      }
    }
  }

  override fun onDestroyView() {
    super.onDestroyView()
    binding = null
  }
}
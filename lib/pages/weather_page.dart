
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:minmal_weather_app/models/weather_model.dart';
import 'package:minmal_weather_app/service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  final _weatherService = WeatherService('5836cb55918ddca62514f92d06748267');
  Weather? _weather;

  _fetchWeather() async{
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    catch (e){
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition){
    if(mainCondition == null) return 'assets/sunny.json';
    switch (mainCondition.toLowerCase()){
      case 'clouds':
        return '/Users/akimaliev/VSProjects/minmal_weather_app/lib/assets/cloudy.json';
      case 'rain':
        return 'assets/rainy.json';
      case 'wind':
        return 'assets/windy.json';
      case 'fog':
      case 'thunderstorm':
      case 'shower rain':
      case 'mist':
      case 'smoke':
      case 'dust':
      default: 
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWeather();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "loading city.."),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            Text('${_weather?.temperature.round()}°C'),
            Text(_weather?.mainCondition ?? "")
          ],
        ),
      ),

    );
  }
}
import 'package:clima_app/services/location.dart';
import 'package:clima_app/services/networking.dart';

const apiKey = '9e1ef70b839cf9c1faad6998c4cead0a';

class WeatherModel {
  Future<dynamic> getInputWeather(String cityName) async {
    var url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';
    networkHelper NetworkHelper = networkHelper(url);

    var weatherData = await NetworkHelper.getData();
    return weatherData;
  }

  Future<dynamic> updateLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    networkHelper NetworkHelper = networkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await NetworkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}

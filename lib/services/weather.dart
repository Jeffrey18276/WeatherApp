import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';


const kapiKey='28f1e23e39be823cfc1d829c371827ed';
const openWeatherMapUrl='https://api.openweathermap.org/data/2.5/weather';


class WeatherModel {


  Future <dynamic> getCityWeather(String cityName){
    var url='$openWeatherMapUrl?q=$cityName&appid=$kapiKey&units=metric';
    NetworkHelper networkHelper= NetworkHelper(url: url);
    var weatherData=networkHelper.getData();
    return weatherData;

  }

  Future <dynamic> getLocationWeather()async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(url:
    '$openWeatherMapUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$kapiKey&units=metric');
    var weatherdata = await networkHelper.getData();
    return weatherdata;

  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '⛈️';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '⛅';
    } else {
      return '🤷‍';
    }
  }

  // String getMessage(int temp) {
  //   if (temp > 25) {
  //     return 'It\'s 🍦 time';
  //   } else if (temp > 20) {
  //     return 'Time for shorts and 👕';
  //   } else if (temp < 10) {
  //     return 'You\'ll need 🧣 and 🧤';
  //   } else {
  //     return 'Bring a 🧥 just in case';
  //   }
  // }
}
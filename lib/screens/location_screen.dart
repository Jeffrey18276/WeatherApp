import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/services/location.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature = 0;
  String weatherIcon = '';
  String cityName = '';
  String weatherMessage = '';
  Location location = Location();
  int humidity = 0;
  double wind = 0.0;
  int pressure = 0;
  String backgroundImage = 'images/night.jpg';

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = '';
        weatherMessage = 'Unable to fetch data';
      } else {
        var temp = weatherData['main']['temp'];
        temperature = temp.toInt();
        cityName = weatherData['name'];
        var condition = weatherData['weather'][0]['id'];
        weatherIcon = weather.getWeatherIcon(condition);
        humidity = weatherData['main']['humidity'];
        wind = weatherData['wind']['speed'];
        pressure = weatherData['main']['pressure'];

        // Set background image based on weather condition
        if (condition == 800) {
          backgroundImage = 'images/image1.jpg'; // Clear sky
        } else if (condition < 600) {
          backgroundImage = 'images/image2.jpg'; // Rainy
        } else if (condition < 700) {
          backgroundImage = 'images/image4.png'; // Snowy
        } else {
          backgroundImage = 'images/image3.jpeg';
          // Other conditions
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    icon: const Icon(
                      Icons.near_me,
                      color: Colors.deepPurple,
                      size: 40.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CityScreen()),
                      );
                      if (typedName != null) {
                        var weatherData =
                        await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.deepPurple,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
              Expanded(

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Text(
                      cityName,
                      style: kMessageTextStyle,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      '$temperature°',
                      style: GoogleFonts.lato(fontSize: 64),


                    ),
                    SizedBox(height:14.0),
                    TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0,end:1),
                        child: Text(
                          weatherIcon,
                          style: kConditionTextStyle,
                        ),
                        duration:const Duration(seconds: 2),
                        builder:(BuildContext context,double val,Widget? child){
                          return Opacity(
                              opacity:val ,
                              child:child);
                        }
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    WeatherInfoCard(
                      title: 'Wind',
                      value: '$wind km/h',
                      color: Colors.greenAccent,
                    ),
                    WeatherInfoCard(
                      title: 'Pressure',
                      value: '$pressure hPa',
                      color: Colors.redAccent,
                    ),
                    WeatherInfoCard(
                      title: 'Humidity',
                      value: '$humidity%',
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  WeatherInfoCard({required this.title, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      color: color,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              value,
              style: GoogleFonts.lato(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
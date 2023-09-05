import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:path/path.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude = 0.0;
  double longitude = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  void getLocation() async {
    WeatherModel weatherModel =  WeatherModel();
    var weatherdata = await weatherModel.getLocationWeather();

    Navigator.push(this.context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherdata,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: SpinKitChasingDots(
        color: Colors.white,
        size: 70.0,
      ),
    ));
  }
}

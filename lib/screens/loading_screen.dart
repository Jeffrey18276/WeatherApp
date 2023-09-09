import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();

    Navigator.push(this.context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinKitChasingDots(
              color: Colors.white,
              size: 70.0,
            ),
            SizedBox(height: 75),
            AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText(
                  'Loading...',
                  textStyle: const TextStyle(
                    fontSize: 40.0,
                    color: Colors.blueAccent
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

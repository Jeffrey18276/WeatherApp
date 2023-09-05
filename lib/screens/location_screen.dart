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
  String CityName = '';
  String weatherMessage = '';
  Location location = Location();
  int humidity=0;
  double wind=0.0;
  int pressure=0;
  String image='';
  String images='images/night.jpg';



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        // while (true) location.getCurrentLocation();
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to fetch data';
      }

      var temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      String placeName = weatherData['name'];
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      //weatherMessage = weather.getMessage(temperature);
      CityName = placeName;
      humidity = weatherData['main']['humidity'];
      wind = weatherData['wind']['speed'];
      pressure = weatherData['main']['pressure'];
      // print(temp);
      // print(condition);

      if(weatherIcon=='☀️'){
        image='images/image1.jpg';
      }
      if(weatherIcon=='⛈️'||weatherData=='☔️'){
        image='images/image2.jpg';
      }
      if(weatherIcon=='🌩'){
        image='images/image3.jpg';
      }
      if(weatherIcon=='☃️'){
        image='images/image4.jpg';
      }
      else{
        image='images/night.jpg';
      }
     images=image;

    }
      );
  }

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(

        decoration: BoxDecoration(
          image: DecorationImage(

            image: AssetImage(images),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
     //   constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CityScreen()));
                      if (typedName != null) {
                        var weatherdata =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherdata);
                      }
                    },
                    child: const Icon(
                      Icons.search,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(top: 1.0),
                child: Expanded(
                  child: Text(
                    '$CityName',
                    textAlign: TextAlign.left,
                    style: kMessageTextStyle,
                  ),
                ),
              ),
SizedBox(height: height*0.27),
              Stack(
                children: [
                  Positioned(
                    child: Padding(
                      padding:const  EdgeInsets.only(left: 5.0*0.1,top:50*0.1),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '$temperature°',
                            style: GoogleFonts.lato(fontSize: 64),
                          ),
                          TweenAnimationBuilder(
                            tween: Tween<double>(begin: 0, end: 1),
                            builder:
                                (BuildContext context, val, Widget? child) {
                              return Opacity(
                                  opacity: val,
                                  child: child
                              );
                            },
                            duration: const Duration(seconds: 3),
                            child: Text(
                              weatherIcon,
                              style: kConditionTextStyle,
                            ),

                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
             SizedBox(height:20),
             Center(
                child:  SizedBox(
                  height: height*0.1,
                  width: width*0.7,
                  child:  Divider(
                    color: Colors.grey.shade400,
                    thickness: 5.0,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(

                      children: [
                        Text(
                          'Wind',
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,

                        ),
                      ),
                        Text(
                            '$wind',
                          style: GoogleFonts.lato(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,

                          ),
                            ),
                        Text(
                          'km/h',
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,

                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 5,
                                width: 50,
                              color: Colors.white30,
                            ),
                            Container(
                              height: 5,
                              width: 5,
                              color: Colors.greenAccent,
                            )
                          ],
                        )
                      ],
                    ),
                    Column(

                      children: [
                        Text(
                          'Pressure',
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,

                          ),
                        ),
                        Text(
                          '$pressure',
                          style: GoogleFonts.lato(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,

                          ),
                        ),
                        Text(
                          '%',
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,

                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 5,
                              width: 50,
                              color: Colors.white30,
                            ),
                            Container(
                              height: 5,
                              width: 5,
                              color: Colors.redAccent,
                            )
                          ],
                        )
                      ],
                    ),
                    Column(

                      children: [
                        Text(
                          'Humdity',
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,

                          ),
                        ),
                        Text(
                          '$humidity',
                          style: GoogleFonts.lato(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,

                          ),
                        ),
                        Text(
                          '%',
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,

                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 5,
                              width: 50,
                              color: Colors.white30,
                            ),
                            Container(
                              height: 5,
                              width: 5,
                              color: Colors.redAccent,
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

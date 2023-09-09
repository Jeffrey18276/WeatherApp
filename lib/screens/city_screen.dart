import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city.png'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      cityName = value;
                    });
                  },
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.location_city,
                      size: 30.0,
                      color: Colors.green,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter City Name',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(
                        width: 1.5,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, cityName);
                },
                child: Container(
                  width: 200.0,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Center(
                    child: Text(
                      'Get Weather',
                      style: kButtonTextStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

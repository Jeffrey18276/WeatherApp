import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:const  BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city.png'),
            fit: BoxFit.cover,
          ),
        ),
        constraints:const  BoxConstraints.expand(),
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
              Container(
                padding: EdgeInsets.all(20.0),

                child: TextField(
                  onChanged: (value){
                      cityName=value;

                  },
                  style: TextStyle(
                    color: Colors.black
                  ),

                  decoration:  InputDecoration(
                    iconColor: Colors.green,
                    filled: true,
                    fillColor: Colors.white,
                    icon:Icon(
                        Icons.location_city,
                      size: 30.0,
                    ),

                    hintText: 'Enter City Name',
                    hintStyle:TextStyle(
                      color: Colors.grey,

                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                        width:1.5,
                        color: Colors.grey
                      )

                    )

                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context,cityName);
                },
                child: SafeArea(
                  child: Container(

                    child: Center(
                      child: Text(
                        'Get Weather',
                        style: kButtonTextStyle,
                      ),
                    ),
                    width: 200.0,

                    decoration: BoxDecoration(
                    color:Colors.black38,
                      borderRadius: BorderRadius.circular(10.0)
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

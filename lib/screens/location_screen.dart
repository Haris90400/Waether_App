import 'package:flutter/material.dart';
import 'package:clima_app/utilities/constants.dart';
import 'package:clima_app/services/weather.dart';
import 'package:clima_app/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;

  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late int temperature;
  late String cityName;
  late String WeatherIcon;
  late String WeatherMessage;
  @override
  void initState() {
    super.initState();
    updateUi(widget.locationWeather);
  }

  void updateUi(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        WeatherIcon = 'Error';
        WeatherMessage = 'Unable to get the location';
        cityName = '';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.round();

      cityName = weatherData['name'];
      var id = weatherData['weather'][0]['id'];
      WeatherModel weather = WeatherModel();
      WeatherIcon = weather.getWeatherIcon(id);
      WeatherMessage = weather.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.updateLocationWeather();
                      updateUi(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (typedName != null) {
                        var weatherData =
                            await weather.getInputWeather(typedName);
                        updateUi(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$WeatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    '$WeatherMessage in $cityName',
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

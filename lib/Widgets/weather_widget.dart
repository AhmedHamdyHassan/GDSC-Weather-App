import 'package:flutter/material.dart';

class WeatherWidget extends StatelessWidget {
  late double feelsLikeTemp, currentTemp;
  late String currentDate;
  // ignore: use_key_in_widget_constructors
  WeatherWidget({
    required this.currentTemp,
    required this.feelsLikeTemp,
    required this.currentDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Today',
          style: TextStyle(
            fontSize: 35,
            color: Colors.white,
          ),
        ),
        Text(
          currentDate,
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          '${currentTemp.ceil()}ºc',
          style: TextStyle(
            fontSize: 60,
            color: Colors.white,
          ),
        ),
        Text(
          'Feels like ${feelsLikeTemp.ceil()}ºc',
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

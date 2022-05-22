import 'package:flutter/material.dart';
import 'package:simple_weather_app/Screens/loading_screen.dart';
import 'package:simple_weather_app/Screens/weather_process_screen.dart';
import 'Screens/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WeatherScreen(),
    );
  }
}

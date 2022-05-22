import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simple_weather_app/Models/connect_with_API_model.dart';
import 'package:simple_weather_app/Screens/loading_screen.dart';
import 'package:simple_weather_app/Screens/weather_process_screen.dart';

import '../Models/weather_model.dart';
import '../Widgets/grid_view_data_widget.dart';
import '../Widgets/weather_widget.dart';
import 'package:geolocator/geolocator.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  bool isLoading = true;
  final StreamController<WeatherModel> _controller = StreamController();
  ConnectWithAPIModel connectWithAPIModel = ConnectWithAPIModel();
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position location = await Geolocator.getCurrentPosition();
    await connectWithAPIModel.fetchWeatherData(
        location.latitude, location.longitude);
    _controller.sink.add(connectWithAPIModel.weatherModel);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _controller.stream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
            return WeatherBodyScreen(
              weatherModel: connectWithAPIModel.weatherModel,
            );
          case ConnectionState.waiting:
            return const LoadingScreen();
          case ConnectionState.none:
            return const LoadingScreen();
          case ConnectionState.done:
            return WeatherBodyScreen(
              weatherModel: connectWithAPIModel.weatherModel,
            );
        }
      },
    );
  }
}

class WeatherBodyScreen extends StatelessWidget {
  const WeatherBodyScreen({
    Key? key,
    required this.weatherModel,
  }) : super(key: key);

  final WeatherModel weatherModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          weatherModel.city,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const WeatherProcessScreen()),
              );
            },
            icon: Icon(Icons.date_range),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(weatherModel.Image, fit: BoxFit.fill),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black38,
          ),
          SafeArea(
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  WeatherWidget(
                    currentDate: weatherModel.CurrentDate,
                    currentTemp: weatherModel.currentWeatherTemp,
                    feelsLikeTemp: weatherModel.feelsLikeTemp,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 3,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 25,
                          left: 25,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GridViewDataWidget(
                              weatherModel: weatherModel,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

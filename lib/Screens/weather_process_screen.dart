import 'package:flutter/material.dart';
import 'package:simple_weather_app/Models/connect_with_API_model.dart';
import 'package:simple_weather_app/Screens/loading_screen.dart';

class WeatherProcessScreen extends StatefulWidget {
  const WeatherProcessScreen({Key? key}) : super(key: key);

  @override
  State<WeatherProcessScreen> createState() => _WeatherProcessScreenState();
}

class _WeatherProcessScreenState extends State<WeatherProcessScreen> {
  bool isLoading = true;
  var _data = [];
  void getDataFromBackend() async {
    ConnectWithAPIModel connectWithAPIModel = ConnectWithAPIModel();
    _data = await connectWithAPIModel.fetchWeahterProcessData();
    print('Iam here');
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getDataFromBackend();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingScreen()
        : Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: Text(
                'Process Weather Screen',
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  child:
                      Image.asset('assets/images/rainy.jpeg', fit: BoxFit.fill),
                ),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.black38,
                ),
                SafeArea(
                    child: ListView.builder(
                  itemBuilder: ((context, index) {
                    return WeatherProcessWidget(
                      temp:
                          _data[index]['weather_temp'].toString().split('.')[0],
                      day: _data[index]['weather_day'],
                      time: _data[index]['weather_time'],
                    );
                  }),
                  itemCount: _data.length,
                ))
              ],
            ),
          );
  }
}

class WeatherProcessWidget extends StatelessWidget {
  late String temp, day, time;
  WeatherProcessWidget({
    Key? key,
    required this.temp,
    required this.day,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height / 10,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Weather Degree: $tempºc",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            "Date: $day",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            "Time: $time",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

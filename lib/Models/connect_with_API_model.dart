import 'dart:convert';

import 'package:http/http.dart' as http;
import '../Models/weather_model.dart';

//localhost:8080/weather/add
class ConnectWithAPIModel {
  late WeatherModel weatherModel;

  Future<void> fetchWeatherData(double _lat, double _long) async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$_lat&lon=$_long&appid=28857cc183fbdddd56a2af8216e9ab96');
    final response = await http.get(url);
    final dataBody = json.decode(response.body);
    final String description = dataBody['weather'][0]['description'];
    final double currentTemp = dataBody['main']['temp'] - 273.15;
    final double feelsLikeTemp = dataBody['main']['feels_like'] - 273.15;
    final double minTemp = dataBody['main']['temp_min'] - 273.15;
    final double maxTemp = dataBody['main']['temp_max'] - 273.15;
    final int pressure = dataBody['main']['pressure'];
    final int humidity = dataBody['main']['humidity'];
    final String country = dataBody['sys']['country'];
    final String city = dataBody['name'];
    final int id = dataBody['weather'][0]['id'];
    weatherModel = WeatherModel(
      currentWeatherTemp: currentTemp,
      description: description,
      feelsLikeTemp: feelsLikeTemp,
      maxTemp: maxTemp,
      minTemp: minTemp,
      pressure: pressure,
      humidity: humidity,
      country: country,
      city: city,
      id: id,
    );
    DateTime date = DateTime.now();
    print(date.toString());
    final day = date.toString().split(' ')[0];
    final time = date.toString().split(' ')[1].split('.')[0];
    url = Uri.parse('http://10.0.2.2:8080/weather/add');
    var responseRequest = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'weather_temp': weatherModel.currentWeatherTemp.ceil().toString(),
          'weather_day': day,
          'weather_time': time,
        }));
    print('Response status: ${responseRequest.statusCode}');
    print('Response body: ${responseRequest.body}');
  }

  Future<dynamic> fetchWeahterProcessData() async {
    var url = Uri.parse('http://10.0.2.2:8080/weather/all');
    final response = await http.get(url);
    final dataBody = json.decode(response.body);
    print(dataBody);
    return dataBody['data'];
  }
}

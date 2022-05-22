// ignore_for_file: file_names
import 'package:date_time_format/date_time_format.dart';

class WeatherModel {
  final int _id;
  final DateTime _today = DateTime.now();
  final double _currentWeatherTemp, _feelsLikeTemp, _minTemp, _maxTemp;
  final int _humidity, _pressure;
  final String _description, _city, _country;

  WeatherModel({
    required double currentWeatherTemp,
    required double feelsLikeTemp,
    required double minTemp,
    required double maxTemp,
    required int humidity,
    required int pressure,
    required int id,
    required String country,
    required String description,
    required String city,
  })  : _currentWeatherTemp = currentWeatherTemp,
        _feelsLikeTemp = feelsLikeTemp,
        _minTemp = minTemp,
        _maxTemp = maxTemp,
        _humidity = humidity,
        _country = country,
        _description = description,
        _pressure = pressure,
        _city = city,
        _id = id;

  double get currentWeatherTemp {
    return _currentWeatherTemp;
  }

  double get feelsLikeTemp {
    return _feelsLikeTemp;
  }

  double get minTemp {
    return _minTemp;
  }

  double get maxTemp {
    return _maxTemp;
  }

  int get humidity {
    return _humidity;
  }

  int get pressure {
    return _pressure;
  }

  String get country {
    return _country;
  }

  String get city {
    return _city;
  }

  String get description {
    return _description;
  }

  // ignore: non_constant_identifier_names
  String get Image {
    if (_id > 800) {
      return 'assets/images/cloudy.jpeg';
    } else if (_id == 800) {
      return 'assets/images/sunny.jpeg';
    } else if (_id > 700) {
      return 'assets/images/atmosphare.jpeg';
    } else if (_id > 600) {
      return 'assets/images/snow.jpeg';
    } else if (_id > 500) {
      return 'assets/images/rainy.jpeg';
    } else if (_id > 300) {
      return 'assets/images/atmosphare.jpeg';
    } else {
      return 'assets/images/thunderstorm.jpeg';
    }
  }

  // ignore: non_constant_identifier_names
  String get CurrentDate {
    String date = _today.format(DateTimeFormats.american);
    List<String> dateWithoutTime = date.split(':');
    date = dateWithoutTime[0].substring(0, dateWithoutTime[0].length - 2);
    return date;
  }
}

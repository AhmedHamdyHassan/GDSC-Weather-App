import 'package:flutter/material.dart';
import 'package:simple_weather_app/Models/weather_model.dart';
import '../Widgets/single_data_column_widget.dart';

class GridViewDataWidget extends StatelessWidget {
  late WeatherModel weatherModel;
  GridViewDataWidget({required this.weatherModel});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 2.2,
        crossAxisSpacing: 15,
        children: [
          SingleDataColumnWidget(
              title: 'MIN TEMP', data: weatherModel.minTemp.ceil().toString()),
          SingleDataColumnWidget(
              title: 'MAX TEMP', data: weatherModel.maxTemp.ceil().toString()),
          SingleDataColumnWidget(
              title: 'PRESSURE', data: weatherModel.pressure.ceil().toString()),
          SingleDataColumnWidget(
              title: 'HUMIDITY', data: weatherModel.humidity.ceil().toString()),
          SingleDataColumnWidget(
              title: 'DISCIPTION', data: weatherModel.description),
          SingleDataColumnWidget(title: 'COUNTRY', data: weatherModel.country),
        ],
      ),
    );
  }
}

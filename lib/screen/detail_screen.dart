import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:riconews/helpers/adapters/weather.dart';
import 'package:riconews/helpers/dio_service.dart';
import 'package:riconews/helpers/states/weather_cubit.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.title, required this.index});
  final String title;
  final int index;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double _counter = 0;

  void _incrementCounter() async {
    var box = await Hive.openBox('weatherBox');
    var weather = box.get('weather');
    setState(() {
      _counter = weather.latitude;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeathersCubit, Weather>(builder: (context, weather) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Your Area's weather on ${weather.time?[widget.index].toString().replaceAll("T", " ")} is:",
                  ),
                  Text(
                    '${weather.temperature?[widget.index]} ${weather.temperatureUnits}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Text("with humidity and precipitation as follows:"),
                  Text(
                      '${weather.humidity?[widget.index]} ${weather.humidityUnits}, ${weather.precipitation?[widget.index]} ${weather.precipitationUnits}')
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

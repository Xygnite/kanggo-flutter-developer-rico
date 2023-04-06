import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:riconews/helpers/adapters/weather.dart';
import 'package:riconews/helpers/dio_service.dart';
import 'package:riconews/helpers/states/weather_cubit.dart';
import 'package:riconews/screen/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      List<Widget> renderList = [];
      weather.time?.asMap().forEach((index, element) {
        renderList.add(Card(
          child: InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailScreen(
                        title: "Your area's weather", index: index))),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(DateTime.parse(element).toString().substring(0, 16)),
                      Text(
                          '${weather.humidity?[index]} ${weather.humidityUnits}, ${weather.precipitation?[index]} ${weather.precipitationUnits}')
                    ],
                  ),
                  Text(
                      '${weather.temperature?[index]} ${weather.temperatureUnits}')
                ],
              ),
            ),
          ),
        ));
      });
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
                  const Text(
                    "Your Area's weather is:",
                  ),
                  Text(
                    weather.temperature?[weather.index].toString() ?? "",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  ...renderList,
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

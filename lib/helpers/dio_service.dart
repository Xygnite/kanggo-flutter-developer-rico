import 'package:dio/dio.dart';
import 'package:riconews/helpers/adapters/weather.dart';

final dio = Dio();

Future<Weather> getWeather() async {
  final response = await dio.get(
      'https://api.open-meteo.com/v1/forecast?latitude=-6.23&longitude=106.99&hourly=temperature_2m,relativehumidity_2m,precipitation&timezone=Asia%2FBangkok');

  Weather weather = Weather.fromjson(response.data);
  return weather;
}

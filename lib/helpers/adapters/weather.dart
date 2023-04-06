import 'package:hive/hive.dart';

part 'weather.g.dart';

@HiveType(typeId: 1)
class Weather extends HiveObject {
  Weather({
    this.latitude,
    this.longitude,
    this.timezone,
    this.timeUnits,
    this.temperatureUnits,
    this.humidityUnits,
    this.precipitationUnits,
    this.time,
    this.temperature,
    this.humidity,
    this.precipitation,
  });

  @HiveField(0)
  double? latitude;

  @HiveField(1)
  double? longitude;

  @HiveField(2)
  String? timezone;

  @HiveField(3)
  String? timeUnits;

  @HiveField(4)
  String? temperatureUnits;

  @HiveField(5)
  String? humidityUnits;

  @HiveField(6)
  String? precipitationUnits;

  @HiveField(7)
  List<dynamic>? time;

  @HiveField(8)
  List<dynamic>? temperature;

  @HiveField(9)
  List<dynamic>? humidity;

  @HiveField(10)
  List<dynamic>? precipitation;

  int index = 0;

  @override
  Weather.fromjson(json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    timezone = json['timezone'];
    timeUnits = json['hourly_units']['time'];
    temperatureUnits = json['hourly_units']['temperature_2m'];
    humidityUnits = json['hourly_units']['relativehumidity_2m'];
    precipitationUnits = json['hourly_units']['precipitation'];
    time = json['hourly']['time'];
    temperature = json['hourly']['temperature_2m'];
    humidity = json['hourly']['relativehumidity_2m'];
    precipitation = json['hourly']['precipitation'];
  }
}

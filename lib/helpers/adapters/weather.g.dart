// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherAdapter extends TypeAdapter<Weather> {
  @override
  final int typeId = 1;

  @override
  Weather read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Weather(
      latitude: fields[0] as double?,
      longitude: fields[1] as double?,
      timezone: fields[2] as String?,
      timeUnits: fields[3] as String?,
      temperatureUnits: fields[4] as String?,
      humidityUnits: fields[5] as String?,
      precipitationUnits: fields[6] as String?,
      time: (fields[7] as List?)?.cast<dynamic>(),
      temperature: (fields[8] as List?)?.cast<dynamic>(),
      humidity: (fields[9] as List?)?.cast<dynamic>(),
      precipitation: (fields[10] as List?)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, Weather obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude)
      ..writeByte(2)
      ..write(obj.timezone)
      ..writeByte(3)
      ..write(obj.timeUnits)
      ..writeByte(4)
      ..write(obj.temperatureUnits)
      ..writeByte(5)
      ..write(obj.humidityUnits)
      ..writeByte(6)
      ..write(obj.precipitationUnits)
      ..writeByte(7)
      ..write(obj.time)
      ..writeByte(8)
      ..write(obj.temperature)
      ..writeByte(9)
      ..write(obj.humidity)
      ..writeByte(10)
      ..write(obj.precipitation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

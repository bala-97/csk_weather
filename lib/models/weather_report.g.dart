// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_report.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherReportAdapter extends TypeAdapter<WeatherReport> {
  @override
  final int typeId = 1;

  @override
  WeatherReport read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherReport(
      cityName: fields[0] as String,
      url: fields[1] as String,
      timeOfReport: fields[2] as double,
      iconUrl: fields[3] as String?,
      windSpeed: fields[4] as double?,
      uvIndex: fields[5] as double?,
      temperature: fields[6] as double?,
      humidity: fields[7] as double?,
      weatherDescription: fields[8] as String?,
      localTime: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherReport obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.cityName)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.timeOfReport)
      ..writeByte(3)
      ..write(obj.iconUrl)
      ..writeByte(4)
      ..write(obj.windSpeed)
      ..writeByte(5)
      ..write(obj.uvIndex)
      ..writeByte(6)
      ..write(obj.temperature)
      ..writeByte(7)
      ..write(obj.humidity)
      ..writeByte(8)
      ..write(obj.weatherDescription)
      ..writeByte(9)
      ..write(obj.localTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherReportAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

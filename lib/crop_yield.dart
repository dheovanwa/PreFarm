import 'package:string_validator/string_validator.dart';

class Yield {
  final String area;
  final String item;
  final double rainFall;
  final double avgTemp;
  final double pesticidesTonnes;
  final double yield;
  final String date;
  final String time;
  final String weather;

  Yield({
    required this.area,
    required this.item,
    required this.rainFall,
    required this.avgTemp,
    required this.pesticidesTonnes,
    required this.yield,
    required this.date,
    required this.time,
    required this.weather,
  });

  factory Yield.fromJson(String area, String item, String rainfall, String pest, String temp, Map<String, dynamic> json, String date, String time, String weather) => Yield(
    area: area,
    item: item,
    rainFall: toDouble(rainfall),
    avgTemp: toDouble(temp),
    pesticidesTonnes: toDouble(pest),
    yield: toDouble(json['prediction']),
    date: date,
    time: time,
    weather: weather
  );

  Yield fromJson(Map<String, dynamic> json, String date, String time, String weather) => Yield(
    area: json['Area'],
    item: json['Item'],
    rainFall: json['average_rain_fall_mm_per_year'],
    avgTemp: json['avg_temp'],
    pesticidesTonnes: json['pesticides_tonnes'],
    yield: json['yield'],
    date: date,
    time: time,
    weather: weather
  );

  Map toJson() => {
    'Area': area,
    'Item': item,
    'average_rain_fall_mm_per_year': rainFall,
    'avg_temp': avgTemp,
    'pesticides_tonnes': pesticidesTonnes,
    'yield': yield,
    'date': date,
    'time': time,
    'weather': weather,
  };
}
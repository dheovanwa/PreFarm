import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prefarm/crop_yield.dart';
import 'package:prefarm/data/history_page_theme.dart' as theme;

class HistoryProvider extends ChangeNotifier {
  int numberOfPrediction = 0;

  List<Yield> listOfYield = [];

  String saveYieldJson(List<Yield> listOfYield) {
    List<Map> listOfYieldJson = listOfYield.map(
      (yieldItems) => yieldItems.toJson()
    ).toList();
    String yieldJson = jsonEncode(listOfYieldJson);
    return yieldJson;
  }

  Future<List<Yield>> readYieldJson() async {
    final directory = await getApplicationDocumentsDirectory();
    final yieldJsonFile = File('${directory.path}/history_yield.json');
    
    try {
      List<dynamic> listOfYieldJson = jsonDecode(await yieldJsonFile.readAsString());
      listOfYield = listOfYieldJson.map(
        (json) => Yield(
          area: json['Area'],
          item: json['Item'],
          rainFall: json['average_rain_fall_mm_per_year'],
          avgTemp: json['avg_temp'],
          pesticidesTonnes: json['pesticides_tonnes'],
          yield: json['yield'],
          date: json['date'],
          time: json['time'],
          weather: json['weather']
        )
      ).toList();

      numberOfPrediction = listOfYield.length;
      notifyListeners();
    } on Exception catch (_) {
      listOfYield = [];

      yieldJsonFile.writeAsString(saveYieldJson(listOfYield));
    }

    return listOfYield;
  }

  Image selectImageFromWeather(Yield currentCard) {
    switch (currentCard.weather) {
      case 'Clear':
        return theme.imageSunny;
      case 'Rainy':
        return theme.imageRainy;
      default:
        return theme.imageCloudy;
    }
  }

  Color selectColorCardFromWeather(Yield currentCard) {
    switch (currentCard.weather) {
      case 'Clear':
        return theme.colorCardSunny;        
      case 'Rainy':
        return theme.colorCardRainy;        
      default:
        return theme.colorCardCloudy;        
    }
  }

  Color selectTopLeftColorCardFromWeather(Yield currentCard) {
    switch (currentCard.weather) {
      case 'Clear':
        return theme.colorCardTopLeftSunny;        
      case 'Rainy':
        return theme.colorCardTopLeftRainy;        
      default:
        return theme.colorCardTopLeftCloudy;        
    }
  }

  Color selectTextColorCardFromWeather(Yield currentCard) {
    switch (currentCard.weather) {
      case 'Clear':
        return theme.colorTextSunny;        
      case 'Rainy':
        return theme.colorTextRainy;        
      default:
        return theme.colorTextCloudy;        
    }
  }

  Color selectBorderColorCardFromWeather(Yield currentCard) {
    switch (currentCard.weather) {
      case 'Clear':
        return theme.colorBorderCardSunny;        
      case 'Rainy':
        return theme.colorBorderCardRainy;        
      default:
        return theme.colorBorderCardCloudy;        
    }
  }

  TextStyle selectTextStyleCardFromWeather(Yield currentCard) {
    switch (currentCard.weather) {
      case 'Clear':
        return theme.styleTextSunny;        
      case 'Rainy':
        return theme.styleTextRainy;        
      default:
        return theme.styleTextCloudy;        
    }
  }

}
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:string_validator/string_validator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:prefarm/crop_yield.dart';
import 'package:prefarm/data/home_page_theme.dart' as theme;
import 'package:prefarm/data/key.dart' as key;

class HomeProvider extends ChangeNotifier {
  HomeProvider({
    this.username = 'User',
    this.selectedPlant = 'Maize',
    this.selectedCountry = 'Indonesia',
    this.selectedSoilType = 'clay',
    this.selectedWaterFrequency = 'daily',
    this.selectedFertilizer = 'none',
  }) {
    init();
  }
  
  Future<void> init() async {
    profile = await readProfileJson();
    username = profile['username'];
    usernameController = TextEditingController(text: profile['username']);

    try {
      Position getPosition = await getCurrentLocation();
      Weather w = await getWeather(getPosition);
      currentTemp = w.temperature!.celsius!.toStringAsFixed(0);
      currentHumidity = w.humidity!.toInt();
      currentWindSpeed = w.windSpeed!.toInt();

      if (['Clear'].contains(w.weatherMain.toString())) {
        currentWeather = w.weatherMain.toString();
        colorWeather = theme.colorSunny;
        weatherImage = theme.weatherSunnyImage;
      } else if (['Thunderstorm', 'Drizzle', 'Rain', 'Snow'].contains(w.weatherMain.toString())) {
        currentWeather = 'Rainy';
        colorWeather = theme.colorRainy;
        weatherImage = theme.weatherRainyImage;
      } else {
        currentWeather = w.weatherMain.toString();
        colorWeather = theme.colorCloudy;
        weatherImage = theme.weatherCloudyImage;
      }
    } catch (e) {
      currentWeather = 'Clouds';
      colorWeather = theme.colorCloudy;
      weatherImage = theme.weatherCloudyImage;

    }


    listOfYield = await readYieldJson();
    latestYield = returnFirstYieldItems();

    notifyListeners();
  }

  void loading(BuildContext currentContext, String msg) {
    showDialog(
      context: currentContext,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFF2F2F2),
          content: Container(
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  msg,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Color(0xFFD09103),
                  ),
                ),
                LoadingAnimationWidget.waveDots(
                  color: const Color(0xFFD09103),
                  size: 40,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Profile
  late TextEditingController usernameController;
  String username;
  late Map<String, dynamic> profile = {
    'username': 'User'
  };


  void setUsername() {
    username = usernameController.text;
    notifyListeners();
  }

  String saveProfileJson(Map<String, dynamic> profile) {
    String profileJson = jsonEncode(profile);
    return profileJson;
  }

  Future<Map<String, dynamic>> readProfileJson() async {
    final directory = await getApplicationDocumentsDirectory();
    final profileJsonFile = File('${directory.path}/profile.json');
    
    try {
      profile = jsonDecode(await profileJsonFile.readAsString());
    } on Exception catch (_) {
      Map<String, dynamic> profile = {
        'username': 'User',
      };

      profileJsonFile.writeAsString(saveProfileJson(profile));
    }

    return profile;
  }

  Future<File> writeToProfileJson() async {
    setUsername();
    profile = {
      'username': username
    };

    final directory = await getApplicationDocumentsDirectory();
    final profileJsonFile = File('${directory.path}/profile.json');
    print(profileJsonFile);
    return profileJsonFile.writeAsString(saveProfileJson(profile));
  }

  Future<File> deleteHistory() async {
    final directory = await getApplicationDocumentsDirectory();

    var yieldJsonFile = File('${directory.path}/history_yield.json');
    if (Platform.isWindows) {
      yieldJsonFile = File('${directory.path}\\history_yield.json');
    } 

    listOfYield = [];
    return yieldJsonFile.writeAsString('[]');
  }

  // Weather Widgets
  final String currentDate = toString(DateFormat('d MMM y').format(DateTime.now()));
  String currentAddress = '-';
  String currentTemp = '-';
  String currentWeather = '-';
  int currentHumidity = 0;
  int currentWindSpeed = 0;
  LinearGradient colorWeather = theme.colorSunny;
  Image weatherImage = theme.weatherSunnyImage;

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled) {
      Geolocator.openLocationSettings();
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location are denied forever");
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      )
    );
  }

  Future<String?> getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placeMarks[0];
      return "${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}";
    } catch (e) {
      return null;
    }
  }

  Future<Weather> getWeather(Position position) async {
    WeatherFactory wf = WeatherFactory(key.openweathermapApiKey); // Use your own api key
    Weather w = await wf.currentWeatherByLocation(position.latitude, position.longitude);
    return w;
  }

  // Crop Yield Prediction
  final List<String> listOfPlant = [
    'Maize',
    'Potatoes',
    'Rice, paddy',
    'Sorghum',
    'Soybeans',
    'Wheat',
  ];

  final List<String> listofCountry = [
    'Albania', 
    'Algeria', 
    'Angola', 
    'Argentina', 
    'Armenia',
    'Australia', 
    'Austria', 
    'Azerbaijan', 
    'Bahamas', 
    'Bahrain',
    'Bangladesh', 
    'Belarus', 
    'Belgium', 
    'Botswana', 
    'Brazil',
    'Bulgaria', 
    'Burkina Faso', 
    'Burundi', 
    'Cameroon', 
    'Canada',
    'Chile', 
    'Colombia', 
    'Croatia',
    'Denmark', 
    'Ecuador', 
    'Egypt', 
    'El Salvador',
    'Eritrea', 
    'Estonia', 
    'Finland', 
    'France', 
    'Germany', 
    'Ghana',
    'Greece', 
    'Guatemala', 
    'Guinea', 
    'Guyana', 
    'Haiti', 
    'Honduras',
    'Hungary', 
    'India', 
    'Indonesia', 
    'Iraq', 
    'Ireland', 
    'Italy',
    'Jamaica', 
    'Japan', 
    'Kazakhstan', 
    'Kenya', 
    'Latvia', 
    'Lebanon',
    'Lesotho', 
    'Libya', 
    'Lithuania', 
    'Madagascar', 
    'Malawi',
    'Malaysia', 
    'Mali', 
    'Mauritania', 
    'Mauritius', 
    'Mexico',
    'Montenegro', 
    'Morocco', 
    'Mozambique', 
    'Namibia', 
    'Nepal',
    'Netherlands', 
    'New Zealand',
    'Nicaragua', 
    'Niger', 
    'Norway',
    'Pakistan', 
    'Peru', 
    'Poland', 
    'Portugal',
    'Qatar', 
    'Romania', 
    'Rwanda', 
    'Saudi Arabia', 
    'Senegal',
    'Slovenia', 
    'South Africa', 
    'Spain', 
    'Sri Lanka', 
    'Sudan',
    'Suriname', 
    'Sweden', 
    'Switzerland', 
    'Tajikistan', 
    'Thailand',
    'Tunisia', 
    'Turkey', 
    'Uganda', 
    'Ukraine', 
    'United Kingdom',
    'Uruguay', 
    'Zambia', 
    'Zimbabwe'
  ];

  List<Yield> listOfYield = [];
  Yield latestYield = Yield(area: '-', item: '-', rainFall: 0, avgTemp: 0, pesticidesTonnes: 0, yield: 0, date: '', time: '', weather: 'Sunny');
  String selectedPlant;
  String selectedCountry;
  TextEditingController pesticideController = TextEditingController();
  TextEditingController temperatureController = TextEditingController();
  TextEditingController rainfallController = TextEditingController();

  bool checkFloat(String str) {
    return isFloat(str);
  }

  Future<Yield> fetchYield(String area, String item, String rainfall, String pest, String temp) async {
    final uri = Uri.parse("https://dheovanwa.pythonanywhere.com/predict/crop-yield/?area=$area&item=$item&rainfall=$rainfall&pesticides=$pest&temp=$temp");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Yield newPrediction = Yield.fromJson(
        area,
        item,
        rainfall,
        pest,
        temp,
        jsonDecode(response.body),
        toString(DateFormat('d MMM y').format(DateTime.now())),
        toString(DateFormat.Hm().format(DateTime.now())),
        currentWeather
      );

      listOfYield.add(newPrediction);
      return newPrediction;
    } else {
      throw Exception('Failed to load.');
    }
  }

  String saveYieldJson(List<Yield> listOfYield) {
    List<Map> listOfYieldJson = listOfYield.map(
      (yieldItems) => yieldItems.toJson()
    ).toList();
    String yieldJson = jsonEncode(listOfYieldJson);
    return yieldJson;
  }

  Future<List<Yield>> readYieldJson() async {
    final directory = await getApplicationDocumentsDirectory();
    var yieldJsonFile = File('${directory.path}/history_yield.json');
    if (Platform.isWindows) {
      yieldJsonFile = File('${directory.path}\\history_yield.json');
    } 

    
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


      if (!isEmptyListOfYield()) latestYield = listOfYield.last;
      notifyListeners();
    } on Exception catch (_) {
      listOfYield = [];

      yieldJsonFile.writeAsString(saveYieldJson(listOfYield));
    }

    return listOfYield;
  }

  Future<File> writeToYieldJson() async {
    final directory = await getApplicationDocumentsDirectory();
    var yieldJsonFile = File('${directory.path}/history_yield.json');
    if (Platform.isWindows) {
      print("windows");
      yieldJsonFile = File('${directory.path}\\history_yield.json');
    } 

    print(yieldJsonFile);
    print(listOfYield.first);
    return yieldJsonFile.writeAsString(saveYieldJson(listOfYield));
  }

  bool isEmptyListOfYield() {
    return listOfYield.isEmpty;
  }

  Yield returnFirstYieldItems() {
    if (isEmptyListOfYield()) {
      return Yield(area: '-', item: '-', rainFall: 0, avgTemp: 0, pesticidesTonnes: 0, yield: 0, date: '', time: '', weather: 'Sunny');
    }

    return Yield(
      area: listOfYield.last.area,
      item: listOfYield.last.item,
      rainFall: listOfYield.last.rainFall,
      avgTemp: listOfYield.last.avgTemp,
      pesticidesTonnes: listOfYield.last.pesticidesTonnes,
      yield: listOfYield.last.yield,
      date: listOfYield.last.date,
      time: listOfYield.last.time,
      weather: listOfYield.last.weather
    );
  }

  void refresh() {
    if (listOfYield.isEmpty) {
      latestYield = Yield(area: '-', item: '-', rainFall: 0, avgTemp: 0, pesticidesTonnes: 0, yield: 0, date: '', time: '', weather: 'Sunny');
      notifyListeners();
    }
  }

  // Success Prediction Button
  List<String> listOfSoil = [
    'clay',
    'sandy',
    'loam'
  ];

  List<String> listOfWaterFrequency = [
    'daily',
    'weekly',
    'bi-weekly',
  ];

  List<String> listOfFertilizer = [
    'none',
    'chemical',
    'organic'
  ];

  String selectedSoilType;
  String selectedWaterFrequency;
  String selectedFertilizer;
  TextEditingController humidityController = TextEditingController();
  TextEditingController sunlightHoursController = TextEditingController();
  TextEditingController successTemperatureController = TextEditingController();
  String result = 'Fail';

  Future<void> fetchSuccessPrediction(String soil, String waterFrequency, String fertilizer, String humidity, String sunlightHours, String temperature) async {
    final uri = Uri.parse("https://dheovanwa.pythonanywhere.com/predict/plant-growth/?soil=$soil&sunlight=$sunlightHours&water=$waterFrequency&fertilizer=$fertilizer&temperature=$temperature&humidity=$humidity");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      String success = await jsonDecode(response.body)['prediction'];

      if (success == '1') {
        result = 'Success';
      }
      else {
        result = 'Fail';
      }
      notifyListeners();
    } else {
      throw Exception('Failed to load.');
    }
  }

  // News Carousel
  int currentNewsPage = 0;

  void setCurrentNewsPage(int pageNumber) {
    currentNewsPage = pageNumber;
    notifyListeners();
  }
}
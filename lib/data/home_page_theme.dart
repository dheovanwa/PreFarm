import 'package:flutter/material.dart';

const String weatherSunnyImagePath = 'assets/images/sun.png';
const String weatherCloudyImagePath = 'assets/images/cloudy.png';
const String weatherRainyImagePath = 'assets/images/rainy.png';

Image weatherSunnyImage = Image.asset(
  weatherSunnyImagePath,
  scale: 1.1,
);
Image weatherCloudyImage = Image.asset(
  weatherCloudyImagePath,
  scale: 1.1,
);
Image weatherRainyImage = Image.asset(
  weatherRainyImagePath,
  scale: 2.2,
);

const LinearGradient colorSunny = LinearGradient(
  colors: [
    Color(0xFF83D6FF),
    Color(0xFF1FB4FF),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const LinearGradient colorCloudy = LinearGradient(
  colors: [
    Color(0xFF9A9A9A),
    Color(0xFF585858)
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const LinearGradient colorRainy = LinearGradient(
  colors: [
    Color(0xFF565656),
    Color(0xFF323131),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
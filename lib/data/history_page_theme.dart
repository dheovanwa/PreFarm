import 'package:flutter/material.dart';

const Color colorTextSunny = Color(0xFF086200);
const Color colorTextRainy = Color(0xFF386F9B);
const Color colorTextCloudy = Color(0xFF546366);

const Color colorCardSunny = Color(0xFFF4F4BD);
const Color colorCardRainy = Color(0xFFA1CAEB);
const Color colorCardCloudy = Color(0xFFBDECF4);

const Color colorCardTopLeftSunny = Color(0xFF89CD1B);
const Color colorCardTopLeftRainy = Color(0xFF346A96);
const Color colorCardTopLeftCloudy = Color(0xFF346A96);

const Color colorBorderCardSunny = Color(0xFF82825F);
const Color colorBorderCardRainy = Color(0xFF59748A);
const Color colorBorderCardCloudy = Color(0xFF59748A);

Image imageSunny = Image.asset(
  'assets/images/sun.png',
  scale: 2.5,
);
Image imageCloudy = Image.asset(
  'assets/images/cloudy.png',
  scale: 2.5,
);
Image imageRainy = Image.asset(
  'assets/images/rainy.png',
  scale: 5,
);

const styleTextSunny = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w700,
  fontSize: 11,
  color: colorTextSunny,
);

const styleTextRainy = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w700,
  fontSize: 11,
  color: colorTextRainy,
);

const styleTextCloudy = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w700,
  fontSize: 11,
  color: colorTextCloudy,
);
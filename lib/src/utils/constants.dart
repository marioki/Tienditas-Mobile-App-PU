import 'package:flutter/material.dart';

// Colors that we use in our app
const kPrimaryColor = Color(0xFF0C9869);
const kTextColor = Color(0xFF3C4046);
const kBackgroundColor = Color(0xFFF9F8FD);

const double kDefaultPadding = 20.0;
const double defaultSeparation = 16;

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'Nunito',
);

final kLabelStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: 'Nunito',
    fontSize: 18);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFFa4a1e5),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

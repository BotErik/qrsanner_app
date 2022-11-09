import 'dart:ui';
import 'package:code_scanner/screens/LandingScreen.dart';
import 'package:code_scanner/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double screenWidth = window.physicalSize.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: COLOR_WHITE,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: COLOR_DARK_BLUE),
        textTheme: screenWidth < 500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT,
        fontFamily: 'Poppins'
      ),
      home: const LandingScreen(),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:mustcompanyy/Account%20setup/countryPage.dart';
import 'package:mustcompanyy/Account%20varification/settingUpPage.dart';
import 'package:mustcompanyy/Account%20varification/takeSelfiePage.dart';
import 'package:mustcompanyy/ProductView/ProductPage.dart';
import 'package:mustcompanyy/Splash.dart';

import 'Account setup/emailPage.dart';
import 'ProductView/ImageViewPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF1976D2),
          onPrimary: Colors.white,
          secondary: Color(0xFF03DAC6),
          onSecondary: Colors.black,
          error: Color(0xFFB00020),
          onError: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black87,
          background: Color(0xFFF6F6F6),
          onBackground: Colors.black,
        )

      ),
      home: Splash(),
    );
  }
}

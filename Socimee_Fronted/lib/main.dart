import 'package:flutter/material.dart';
import 'package:socimee/view/home.dart';
import 'package:socimee/view/profileConfiguration.dart';
import 'package:socimee/view/profileDescription.dart';
import 'package:socimee/view/profileList.dart';
import 'package:socimee/view/profilePersonality.dart';
import 'package:socimee/view/profileRegister.dart';
import 'package:socimee/view/signHome.dart';
import 'package:socimee/view/signup.dart';
import 'package:socimee/view/userInfo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/signHome': (context) => SignHome(),
        '/signup': (context) => SignUp(),
        '/profileRegister': (context) => ProfileRegister(),
        '/profilePersonality': (context) => ProfilePersonality(),
        '/profileDescription': (context) => ProfileDescription(),
        '/socimeeHome': (context) => Home(),
        '/profileConfiguration': (context) => ProfileConfiguration(),
        '/userInfo': (context) => AccountSettings(),
        '/updateUser': (context) => UpdateUser(),
        '/profilesList': (context) => SelectProfile()
      },
      title: 'Socimee',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white
        ),           
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
          ),
        ),
      ),
      home: SignHome(),
    );
  }
}

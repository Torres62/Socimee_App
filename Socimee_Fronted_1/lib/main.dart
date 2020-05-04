import 'package:flutter/material.dart';
import 'package:socimee/view/home.dart';
import 'package:socimee/view/profileConfiguration.dart';
import 'package:socimee/view/profileDescription.dart';
import 'package:socimee/view/profilePersonality.dart';
import 'package:socimee/view/profileRegister.dart';
import 'package:socimee/view/signHome.dart';
import 'package:socimee/view/signin.dart';
import 'package:socimee/view/signup.dart';
import 'package:socimee/view/userInfo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context) => SignHome(),
        '/signin': (context) => SignIn(),
        '/signup': (context) => SignUp(),
        '/profileRegister': (context) => ProfileRegister(),
        '/profilePersonality': (context) => ProfilePersonality(),
        '/profileDescription': (context) => ProfileDescription(),
        '/socimeeHome': (context) => Home(),
        '/profileConfiguration': (context) => ProfileConfiguration(),
        '/userInfo': (context) => UserInfo(),
      },
      title: 'Socimee',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: SignHome(),
    );
  }
}

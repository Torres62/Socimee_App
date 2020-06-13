import 'package:flutter/material.dart';
import 'package:socimee/view/changePassword.dart';
import 'package:socimee/view/home.dart';
import 'package:socimee/view/profileSettings.dart';
import 'package:socimee/view/profileDescription.dart';
import 'package:socimee/view/profileList.dart';
import 'package:socimee/view/profilePersonality.dart';
import 'package:socimee/view/profileRegister.dart';
import 'package:socimee/view/signHome.dart';
import 'package:socimee/view/signup.dart';
import 'package:socimee/view/userInfo.dart';

void main() {
  runApp(Socimee());  
}

class Socimee extends StatelessWidget {

  @override
  Widget build(BuildContext context) {        
    return MaterialApp(
      initialRoute: '/signHome',
      routes: {
        '/signHome': (context) => SignHome(),
        '/signup': (context) => SignUp(),
        '/profileRegister': (context) => ProfileRegister(),
        '/profilePersonality': (context) => ProfilePersonality(),
        '/profileDescription': (context) => ProfileDescription(),
        '/socimeeHome': (context) => Home(),
        '/profileSettings': (context) => ProfileSettings(),
        '/userInfo': (context) => AccountSettings(),
        '/profilesList': (context) => SelectProfile(),
        '/changePassword': (context) => ChangePassword(),
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
    );
  }
}

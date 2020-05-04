import 'package:flutter/material.dart';
import 'package:socimee/view/signin.dart';
import 'package:socimee/view/signup.dart';

class SignHome extends StatefulWidget{
  @override
  State<StatefulWidget> createState()  => SignHomeState();
}

class SignHomeState extends State<SignHome>{
  
  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      body: SafeArea(
        child: _buildHomeScreen(),        
      ),
    );
  }

  Widget _buildHomeScreen(){
    return Center(
      child: Container(        
        margin: EdgeInsets.fromLTRB(30, 20, 30, 20),        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildLogoImage(),
            _buildSignInButton(),
            _buildSignUpButton(),
          ],
        ),
      )
    );
  }

  Widget _buildLogoImage(){
    return Container(
    );
  }

  Widget _buildSignInButton(){
    return Container(    
      //color: Colors.red,  
      margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
      height: 60,
      width: 250,
      child: RaisedButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => SignIn(),
          ));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.deepPurple,
        child: Text('Sign In', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
      ),
    );
  }

  Widget _buildSignUpButton(){
   return Container(
    margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
    height: 60,
    width: 250,
     child: RaisedButton(
       onPressed: (){
        Navigator.push(context, MaterialPageRoute(
           builder: (context) => SignUp(),
        ));
       },
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
       color: Colors.deepPurple,
       child: Text('Sign Up', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
      ),
   );
  }
}
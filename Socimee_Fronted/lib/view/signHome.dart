import 'package:flutter/material.dart';
import 'package:socimee/controller/restApi.dart';
import 'package:socimee/utils/ColorConverter.dart';

class SignHome extends StatefulWidget{
  @override
  State<StatefulWidget> createState()  => SignHomeState();
}

class SignHomeState extends State<SignHome>{

  final formKey = GlobalKey<FormState>();
  String _email;
  String _password;  

  final String url = 'http://192.168.0.178:8084/Socimee/socimee/user/login';
  Map<String, dynamic> body;

  void _validateAndSubmit() async{
    final form = formKey.currentState;
    if (form.validate()){
      form.save();

      body = {"email": _email, "password": _password}; 

      await  HttpRequest().doLogin(url, body).then((String id){        
        if(id != "null"){                              
          Navigator.of(context).pushNamed('/socimeeHome');
        } else{
          _returnToSignIn();            
        }
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {    
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: _buildHomeScreen(),
      ),
    );
  }

  Widget _buildHomeScreen(){
    return Container(            
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorConverter().backgroundFirstColor(),
            ColorConverter().backgroundSecondColor()
          ],
        ),
      ),             
      child: Center(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildTitle(),
              _buildLoginForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(){
    return Text(
      'SOCIMEE', 
      style: TextStyle(
        color: Colors.white,
        fontSize: 48,
        letterSpacing: 4
    ));
  }

  Widget _buildLoginForm(){
    return Container( 
      margin: EdgeInsets.all(16),    
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildEmailFormField(),
            SizedBox(height: 20),
            _buildPasswordField(),
            _buildLoginButton(),
            _buildSignUpRow()
          ],
        )
      ),
    );
  }

  Widget _buildEmailFormField(){
    return TextFormField(
      maxLines: 1,
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(Icons.email, color: Colors.white),
      ),   
      validator: (value) => value.isEmpty ? "Email can\'t be empty" : null,   
      onSaved: (value) => _email = value,
    );
  }

  Widget _buildPasswordField(){
    return TextFormField(
      obscureText: true,
      maxLength: 16,
      maxLines: 1,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(Icons.lock, color: Colors.white),
      ),
      validator: (value) => value.isEmpty ? "Password can\'t be empty" : null,
      onSaved: (value) => _password = value,
    );
  }

  Widget _buildLoginButton(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 30),
      child: Container(
        height: 40,
        child: RaisedButton(
          padding: EdgeInsets.all(0),
          onPressed: (){
            _validateAndSubmit();
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
          color: ColorConverter().backgroundFirstColor().withOpacity(0.7),
          child: Text(
            'Log In',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Dont\'t hava an account?',
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
          child: GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed('/signup');
            },
            child: Text(
              'Sign Up!',
              style: TextStyle(
                color: ColorConverter().textBlueColor(),
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _returnToSignIn(){
    Future.delayed(Duration(seconds: 0), (){
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            title: Text(
              'Invalid values', 
              style: TextStyle(
                color: ColorConverter().textBlueColor()
              ),
            ),
            content: Text(
              'Email or password invalid',
              style: TextStyle(
                color: ColorConverter().textBlueColor()
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.pop(context); 
                },
                child: Text(
                  'Try Again',
                  style: TextStyle(
                    color: ColorConverter().textBlueColor()
                  ),
                )
              ),
            ],
          );
        }
      );
    }); 
  }
}
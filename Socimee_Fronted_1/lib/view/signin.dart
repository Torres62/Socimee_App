import 'package:flutter/material.dart';
import 'package:socimee/controller/restApi.dart';
import 'package:socimee/view/home.dart';

class SignIn extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SignInState();
}

class SignInState extends State<SignIn>{
  
  final formKey = new GlobalKey<FormState>();

  final String url = 'http://192.168.0.178:8084/Socimee/socimee/user/login';

  String email;
  String password;
  Map<String, dynamic> body;

  @override
  Widget build(BuildContext context) => _buildHome();

  void validateAndSubmit(){
    final form = formKey.currentState;
    if (form.validate()){
      form.save();
      
      body = {"email": email, "password": password}; 

      Future.delayed(Duration(seconds: 2), (){
        HttpRequest().doLogin(url, body).then((String id){        
          if(id.isNotEmpty){                              
            Navigator.of(context).pushNamed('/socimeeHome', arguments: id);
          } else{
            _returnToSignIn(); 
          }
        });
      });     
    }
  }

  Widget _buildHome(){
    return Scaffold(
      body: SafeArea(
        child: _buildForm(),
      ),
    );
  }

  Widget _buildForm(){
    return Form(      
      key: formKey,    
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildEmailField(),
          _buildPasswordField(),
          _buildSubmitButton(), 
        ],
      )
    );
  }

  Widget _buildEmailField(){
    return  Padding(
      padding: EdgeInsets.all(24),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        maxLines: 1,        
        decoration: InputDecoration(
          hintText: 'Email',
          icon: Icon(Icons.alternate_email, color: Colors.deepPurple),     
        ),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value){
          email = value;
        },        
      ),
    );
  }

  Widget _buildPasswordField(){
    return Padding(
      padding: EdgeInsets.all(24),
      child: TextFormField( 
        keyboardType: TextInputType.text,
        maxLength: 16,
        maxLines: 1,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Password',
          icon: Icon(Icons.lock, color: Colors.deepPurple),
        ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value){
          password = value;
        },
      ),
    );
  }

  Widget _buildSubmitButton(){
    return Padding(
      padding: EdgeInsets.all(16),
      child: Container(          
        width: 160,
        height: 40,
        child: RaisedButton(
          onPressed: (){ 
            showDialog(
              context: context,
              builder: (BuildContext context){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            );            
            validateAndSubmit();                                  
          },
          color: Colors.deepPurple,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Text('Sign In', style: TextStyle(color: Colors.white)),    
        ),
      ),
    );      
  }

  void _returnToSignIn(){
    Future.delayed(Duration(seconds: 0), (){
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Invalid values'),
            content: Text('Email or password invalid'),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.of(context).pushNamed('/signin'); 
                },
                child: Text('Try Again'))
            ],
          );
        }
      );
    }); 
  }
}
import 'package:flutter/material.dart';
import 'package:socimee/controller/restApi.dart';
import 'package:socimee/utils/ColorConverter.dart';

class SignUp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SignUpState();
}

class SignUpState extends State<SignUp>{
  final formKey = new GlobalKey<FormState>();

  final String url = 'http://192.168.0.178:8084/Socimee/socimee/user/create';

  String email;
  String password;
  Map<String, dynamic> body;

  @override
  Widget build(BuildContext context) => _buildHome();

  void validateAndSubmit() async{
    final form = formKey.currentState;
    if (form.validate()){
      form.save();

      body = {"id": null, "email": email, "password": password};

      await HttpRequest().doCreate(url, body).then((String idUser){
        if(idUser != "null"){
        Navigator.of(context).pushNamed('/profileRegister', arguments: idUser);
        } else{
          _returnToSignUp();
        }
      });
    }
  }

  Widget _buildHome(){
    return Scaffold(
      body: Container(
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
        child: _buildForm()
      ),
    );
  }

  Widget _buildForm(){
    return Center(
      child: Container(
        margin: EdgeInsets.all(32),
        child: Form(      
          key: formKey,    
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,        
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildEmailField(),
              _buildPasswordField(),
              _buildSubmitButton(),
            ],
          )
        ),
      ),
    );
  }

  Widget _buildEmailField(){
    return  TextFormField(
      keyboardType: TextInputType.emailAddress,
      maxLines: 1,
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(Icons.alternate_email, color: Colors.white),     
      ),
      validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
      onSaved: (value){
        email = value;
      },        
    );
  }

  Widget _buildPasswordField(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 32),
      child: TextFormField( 
        keyboardType: TextInputType.text,
        maxLength: 16,
        maxLines: 1,
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(color: Colors.white),
          prefixIcon: Icon(Icons.lock, color: Colors.white),
        ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value){
          password = value;
        },
      ),
    );
  }

  Widget _buildSubmitButton(){
    return Container(          
      height: 40,
      child: RaisedButton(
        onPressed: (){            
          validateAndSubmit();
        },
        color: ColorConverter().backgroundFirstColor().withOpacity(0.7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Text(
          'Signup',
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
    );      
  } 

  void _returnToSignUp(){
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
              'Email already exists',
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
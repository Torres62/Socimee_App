import 'package:flutter/material.dart';
import 'package:socimee/controller/restApi.dart';
import 'package:socimee/utils/ColorConverter.dart';

class ChangePassword extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword>{
  final formKey = GlobalKey<FormState>();

  String idUser;
  String _newPassword;
  String _confirmedPassword;
  Map<String, dynamic> body;

  final String url = "http://192.168.0.178:8084/Socimee/socimee/user/changePassword";

  void _validateAndSave(){
    final form = formKey.currentState;
    if (form.validate()){
      form.save();      
      if(_newPassword == _confirmedPassword){
        body = {"id": idUser, "password": _newPassword};

        Future.delayed(Duration(seconds: 2), (){
          HttpRequest().doPut(url, body).then((String id){
            if(id != "false"){
              _alertPasswordUpdated();
            }
          });
        });
      } else {

      }
    }
  }

  void _alertPasswordUpdated(){
    Future.delayed(Duration(seconds: 1), (){
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 50,
            ),
            content: Text(
              'Profile updated',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white
              ),
            ),
            backgroundColor: ColorConverter().backgroundFirstColor().withOpacity(0.6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32)
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              )
            ],
          );
        }
      );
    });
  }
  
  @override
  Widget build(BuildContext context) {
    idUser = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: _buildChangePasswordLayout(),
      appBar: _buildAppBar(),
    );
  }
  
  Widget _buildChangePasswordLayout(){
    return Container(
      margin: EdgeInsets.all(24),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildFormField('New Password', 'New Password can\'t be empty'),
            _buildFormField('Confirm Password', 'Confirm Password can\'t be empty'),
            _buildChangePasswordButton(),
          ],
        ),
      ),
    );      
  }

  Widget _buildFormField(String label, String error){
    return Container(
      margin: EdgeInsets.fromLTRB(0, 32, 0, 0),
      child: TextFormField(
        obscureText: true,
        style: TextStyle(
          color: Colors.black
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: ColorConverter().backgroundFirstColor()
          ),        
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(
              color: Colors.blue
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(
              color: Colors.blue
            ),
          ),
        ),
        validator: (value) => value.isEmpty ? error : null,
        onSaved: (value){
          if (label == 'New Password'){
            _newPassword = value;
          }
          else if (label == 'Confirm Password'){
            _confirmedPassword = value;
          }
        },        
      ),
    );
  }

  Widget _buildChangePasswordButton(){
    return Container(
      height: 50,
      margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
      child: RaisedButton(
        onPressed: (){
          _validateAndSave();      
        },
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                ColorConverter().backgroundFirstColor(),
                ColorConverter().backgroundSecondColor()
              ],              
            ),
            borderRadius: BorderRadius.circular(32)
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Change Password',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildAppBar(){
    return AppBar(
      title: Text(
        'Change Password',
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              ColorConverter().backgroundSecondColor(),
              ColorConverter().backgroundFirstColor()
            ]
          ),
        ),
      ),
    );
  }
}
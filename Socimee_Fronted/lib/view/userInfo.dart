import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socimee/controller/restApi.dart';
import 'package:socimee/utils/ColorConverter.dart';

class AccountSettings extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => AccountSettingsState();
}

class AccountSettingsState extends State<AccountSettings>{

  String idUser;
  String _email;
  bool isConfirmed = false;
  Map<String, dynamic> body;

  final String url = "http://192.168.0.178:8084/Socimee/socimee/user/updateEmail";
  String deleteUrl = "http://192.168.0.178:8084/Socimee/socimee/user/delete/";

  final formKey = GlobalKey<FormState>();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildAccountSettings(),
      appBar: _buildAppBar(),
    );
  }

  void _validateAndSave() async{
    final form = formKey.currentState;
    if(form.validate()){
      form.save();

      await HttpRequest().getLogin().then((String id){
          idUser = id;        
      });   

      body = {"id": idUser, "email": _email};

      await HttpRequest().doPut(url, body).then((String id){
          if(id != "false"){
            _alertProfileCreated();
          }
      }); 
    }
  }

  void _alertProfileCreated(){
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

  Widget _buildAppBar(){
    return AppBar(
      title: Text(
        'Account Settings',
        style: TextStyle(
          color: Colors.white
        ),
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorConverter().backgroundSecondColor(),
              ColorConverter().backgroundFirstColor()
            ],
          ),
        ),        
      ),
    );
  }

  Widget _buildAccountSettings(){
    return Container(
      margin: EdgeInsets.all(32),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildFormField('Email', 'Email can\'t be empty'),
            _buildUpdateButton(),
            _buildChangePasswordButton(),
            _buildDeleteButton(),            
          ],
        ),
      ),
    );
  }

  Widget _buildFormField(String label, String error){
    return Container(
      margin: EdgeInsets.fromLTRB(0, 32, 0, 0),
      child: TextFormField(    
        style: TextStyle(
          color: Colors.black,
        ),   
        decoration: InputDecoration(          
          fillColor: Colors.blue,
          labelText: label,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(
              color: Colors.blue
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(
              color: Colors.blue
            ),
          ),   
        ),
        validator: (value) => value.isEmpty ? error : null,
        onSaved: (value){
          if (label == 'Email'){
            _email = value;
          }   
        },
      ),
    );
  }

  Widget _buildUpdateButton(){
    return Container(
      height: 50,
      margin: EdgeInsets.fromLTRB(0, 32, 0, 0),
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
              'Update Email',
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

  Widget _buildChangePasswordButton(){
    return Container(
      height: 50,
      margin: EdgeInsets.fromLTRB(0, 32, 0, 0),
      child: RaisedButton(
        onPressed: (){       
          Navigator.of(context).pushNamed('/changePassword', arguments: idUser);
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

  Widget _buildDeleteButton(){
    return Container(
      height: 50,
      margin: EdgeInsets.fromLTRB(0, 32, 0, 0),
      child: RaisedButton(
        onPressed: (){       
          _alertAccountDeleted();
        },
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.red,
                Colors.red
              ],              
            ),
            borderRadius: BorderRadius.circular(32)
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Delete Account',
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

  void _alertAccountDeleted(){
    Future.delayed(Duration(seconds: 1), (){
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            content: Text(
              'Are you sure you want do delete account?',
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
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white
                  ),
                )
              ),
              FlatButton(
                onPressed: (){
                  _deleteAccount();
                },
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),              
            ],
          );
        }
      );
    });
  }

  void _deleteAccount(){
    deleteUrl = deleteUrl + idUser;
    print(deleteUrl);
    HttpRequest().doDelete(deleteUrl).then((String id){
      if(id != "false"){
        Navigator.of(context).pushNamed('/signHome');
      }
    });
  }

}
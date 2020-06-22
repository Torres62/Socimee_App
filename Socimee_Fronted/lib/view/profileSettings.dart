import 'package:flutter/material.dart';
import 'package:socimee/controller/restApi.dart';
import 'package:socimee/utils/ColorConverter.dart';

class ProfileSettings extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ProfileSettingsState();
}

class ProfileSettingsState extends State<ProfileSettings>{

  var profile;
  final formKey = GlobalKey<FormState>();

  var urlToDeleteProfile = 'http://192.168.0.178:8084/Socimee/socimee/profile/delete/';
  var urlToUpdateProfile = 'http://192.168.0.178:8084/Socimee/socimee/profile/update';

  @override
  Widget build(BuildContext context) {
    profile = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildProfileSettingsList(),
    );
  }

  Widget _buildAppBar(){
    return AppBar(
      title: Text('${profile["nome"]} Profile'),  
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorConverter().backgroundSecondColor(),
              ColorConverter().backgroundFirstColor()
            ]
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSettingsList(){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(40),
        child: Form(
          key: formKey,
          child: Expanded(
            child: ListView(
              children: <Widget>[
                _buildFormTextField('Name can\'t be empty', profile['nome'], 'Name'),
                _buildFormTextField('Sex can\'t be empty', profile['sexo'], 'Sex'),
                _buildFormTextField('Birth Date can\'t be empty', profile['dataNascimento'], 'Birth Date'),
                _buildFormTextField('Max Distance Date can\'t be empty', profile['distanciaMaxima'].toString(), 'Max Distance'),
                _buildFormTextField('Age Range Date can\'t be empty', profile['faixaEtaria'].toString(), 'Age Range'),
                _buildFormTextField('Profile status can\'t be empty', profile['statusPerfil'], 'Profile Status'),
                _buildFormTextField('Favorite Movie can\'t be empty', profile['filme'], 'Favorite Movie'),
                _buildFormTextField('Favorite Music can\'t be empty', profile['musica'], 'Favorite Music'),
                _buildFormTextField('Favorite TV Show can\'t be empty', profile['serie'], 'Favorite TV Show'),
                _buildFormTextField('Favorite Anime can\'t be empty', profile['anime'], 'Favorite Anime'),
                _buildFormTextField('Occupation can\'t be empty', profile['ocupacao'], 'Occupation'),
                _buildFormTextField('Description can\'t be empty', profile['descricao'], 'Description'),
                _buildUpdateAccountButton(),
                _buildDeleteAccountButton(),
              ],
            ),
          )
        ),
      ),
    );
  }

  Widget _buildFormTextField(String error, String initialValue, String label){ 
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 32),
      child: TextFormField(
        initialValue: initialValue,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: ColorConverter().backgroundFirstColor()),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: ColorConverter().backgroundFirstColor())
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: ColorConverter().backgroundFirstColor())
          ), 
        ),
        validator: (value) => value.isEmpty ? error : null,
        onSaved: (value){
          if(label == 'Name') profile['nome'] = value;
          if(label == 'Sex') profile['sexo'] = value;
          if(label == 'Birth Date') profile['dataNascimento'] = value;
          if(label == 'Max Distance') profile['distanciaMaxima'] = value;
          if(label == 'Age Range') profile['faixaEtaria'] = value;
          if(label == 'Profile Status') profile['statusPerfil'] = value;
          if(label == 'Favorite Movie') profile['filme'] = value;
          if(label == 'Favorite Music') profile['musica'] = value;
          if(label == 'Favorite TV Show') profile['serie'] = value;
          if(label == 'Favorite Anime') profile['anime'] = value;
          if(label == 'Occupation') profile['ocupacao'] = value;
          if(label == 'Description') profile['descricao'] = value;
        },
      ),
    );
  }

  Widget _buildUpdateAccountButton(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
      child: Container(
        height: 50,
        child: RaisedButton(
          onPressed: (){
            _validateAndSaveProfile();
          },
          padding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  ColorConverter().backgroundFirstColor(),
                  ColorConverter().backgroundSecondColor()
                ]
              ),
            ),
            child: Container(                          
              alignment: Alignment.center,
              child: Text(
                'Update Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
                ),
              ),
            ),
          ),
        ),
      ),
    );   
  }

  Widget _buildDeleteAccountButton(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
      child: Container(
        height: 50,
        child: RaisedButton(
          onPressed: (){
            _deleteProfile();
          },
          padding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Colors.red              
            ),
            child: Container(                          
              alignment: Alignment.center,
              child: Text(
                'Delete Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
                ),
              ),
            ),
          ),
        ),
      ),
    );   
  }

  void _validateAndSaveProfile() async{
    final form = formKey.currentState;
    if(form.validate()){
      form.save();
      await HttpRequest().doPut(urlToUpdateProfile, profile).then((String isProfileUpdated) {
        if(isProfileUpdated == 'true'){
          _profileUpdated();
        }
      });
    }
  }

  void _profileUpdated(){
    Future.delayed(Duration(seconds: 0), (){
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            title: Text(
              'Profile Updated', 
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
                  'Confirm',
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

  void _deleteProfile() async{
    urlToDeleteProfile = urlToDeleteProfile + profile['idProfile'].toString();
    await HttpRequest().doDelete(urlToDeleteProfile).then((String isProfileDeleted){
      if(isProfileDeleted == 'true'){
        _profileDeleted();
      }
    });
  }

  void _profileDeleted(){
    Future.delayed(Duration(seconds: 0), (){
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            title: Text(
              'Profile Deleted', 
              style: TextStyle(
                color: ColorConverter().textBlueColor()
              ),
            ),            
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.pop(context); 
                  Navigator.pop(context); 
                },
                child: Text(
                  'Confirm',
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

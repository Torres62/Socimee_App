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

  String sex;

  bool profileStatus;

  var faixaEtaria;
  var distanciaMaxima;

  var urlToDeleteProfile = 'http://192.168.0.178:8084/Socimee/socimee/profile/delete/';
  var urlToUpdateProfile = 'http://192.168.0.178:8084/Socimee/socimee/profile/update';

  loadMaxDistanceAndAgeRangeAndProfileStatus(){
    if(this.faixaEtaria == null){
      int faixaDeInicio = profile["faixaEtaria"];
      this.faixaEtaria = faixaDeInicio.toDouble();
    }
    if(this.distanciaMaxima == null){
      int distanciaDeInicio = profile["distanciaMaxima"];
      this.distanciaMaxima = distanciaDeInicio.toDouble();
    }   

    print(profileStatus);

    //Defines profile stats
    if(profileStatus == null){
      if (profile["statusPerfil"] == "T") {       
        profileStatus = true;
      } 
      else if (profile["statusPerfil"] == "F"){
        profileStatus = false;
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    profile = ModalRoute.of(context).settings.arguments;
    loadMaxDistanceAndAgeRangeAndProfileStatus();
      
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
                Text(
                  'Gender',
                  style: TextStyle(
                    color: ColorConverter().backgroundFirstColor()
                  ),
                ),
                _buildSexField(),
                _buildFormTextField('Birth Date can\'t be empty', profile['dataNascimento'], 'Birth Date'),
                Text(
                  'Max Distance',
                  style: TextStyle(
                    color: ColorConverter().backgroundFirstColor()
                  )
                ),
                _buildMaxDistance(),
                Text(
                  'Age Range',
                  style: TextStyle(
                    color: ColorConverter().backgroundFirstColor()
                  )
                ),
                _buildAgeRangeSlider(),
                Text(
                  'Profile Status',
                  style: TextStyle(
                    color: ColorConverter().backgroundFirstColor()
                  )
                ),
                _buildStatusSwitch(),
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

  Widget _buildSexField(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,0,0,16),
      child: Row(
        children: <Widget>[
          _buildSexMale('Male', 'M'),
          _buildSexFemale('Female', 'F'),
        ],
      ),
    );
  }

  Widget _buildSexMale(String sexName, String sexValue){
    sex = profile['sexo'];
    return Flexible(
      child: RadioListTile(
        title: Text(sexName, style: TextStyle(color: ColorConverter().backgroundFirstColor())),
        groupValue: sex,
        value: sexValue,
        activeColor: ColorConverter().backgroundSecondColor(),
        onChanged: (String value){
          setState(() {
            sex = value;
          });
        },        
      ),
    );
  }

  Widget _buildSexFemale(String sexName, String sexValue){
    sex = profile['sexo'];
    return Flexible(
      child: RadioListTile(
        title: Text(sexName, style: TextStyle(color: ColorConverter().backgroundFirstColor())),
        groupValue: sex,
        value: sexValue,
        activeColor: ColorConverter().backgroundSecondColor(),
        onChanged: (String value){
          setState(() {
            sex = value;
          });
        },
      ),
    );
  }

  Widget _buildMaxDistance(){
  return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: ColorConverter().backgroundFirstColor(),
        inactiveTrackColor: ColorConverter().backgroundFirstColor().withOpacity(0.5),
        trackShape: RoundedRectSliderTrackShape(),
        trackHeight: 4.0,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
        thumbColor: ColorConverter().backgroundFirstColor(),
        overlayColor: ColorConverter().backgroundFirstColor(),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
        tickMarkShape: RoundSliderTickMarkShape(),
        activeTickMarkColor: ColorConverter().backgroundSecondColor(),
        inactiveTickMarkColor: ColorConverter().backgroundSecondColor().withOpacity(0.5),
        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
        valueIndicatorColor: ColorConverter().backgroundSecondColor(),
        valueIndicatorTextStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      child: Slider(
        value: this.distanciaMaxima,
        min: 0,
        max: 100,
        divisions: 20,
        label: '${this.distanciaMaxima}',
        onChanged: (double value) {
          setState(
            () {
              this.distanciaMaxima = value;
            },
          );
        },
      ),
    );  
  }

  Widget _buildAgeRangeSlider(){
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: ColorConverter().backgroundFirstColor(),
        inactiveTrackColor: ColorConverter().backgroundFirstColor().withOpacity(0.5),
        trackShape: RoundedRectSliderTrackShape(),
        trackHeight: 4.0,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
        thumbColor: ColorConverter().backgroundFirstColor(),
        overlayColor: ColorConverter().backgroundFirstColor(),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
        tickMarkShape: RoundSliderTickMarkShape(),
        activeTickMarkColor: ColorConverter().backgroundSecondColor(),
        inactiveTickMarkColor: ColorConverter().backgroundSecondColor().withOpacity(0.5),
        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
        valueIndicatorColor: ColorConverter().backgroundSecondColor(),
        valueIndicatorTextStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      child: Slider(
        value: this.faixaEtaria,
        min: 18,
        max: 100,
        divisions: 82,
        label: '${this.faixaEtaria}',
        onChanged: (double value) {
          setState(
            () {
              this.faixaEtaria = value;
            },
          );
        },
      ),
    );
  }

  Widget _buildStatusSwitch(){
    return Row(
      children: <Widget>[
        Switch(            
          value: profileStatus,           
          onChanged: (value){
            setState(() {
              profileStatus = value;
            });
          }
        ),
      ],
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
          if(label == 'Birth Date') profile['dataNascimento'] = value;
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

            //Parse do double para int para string
      int faixaInt = faixaEtaria.toInt();
      profile["faixaEtaria"] = faixaInt.toString();
      
      int distanciaInt = distanciaMaxima.toInt();
      profile['distanciaMaxima'] = distanciaInt.toString();

      profile["sexo"] = sex;

      //Defines profile stats
      if (profileStatus) {       
        profile["statusPerfil"] = "T";
      } else{
        profile["statusPerfil"] = "F";
      }

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

import 'package:flutter/material.dart';
import 'package:socimee/controller/restApi.dart';
import 'package:socimee/utils/ColorConverter.dart';

class CreateNewProfile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => CreateNewProfileState();
}

class CreateNewProfileState extends State<CreateNewProfile>{

  String userID;
  Map<String, dynamic> profile;
  final formKey = GlobalKey<FormState>();

  var urlToCreateProfile = 'http://192.168.0.178:8084/Socimee/socimee/profile/create';

  void _getUserID() async{
    await HttpRequest().getLogin().then((String id){
      this.userID = id;
    });
    profile = {
      "nome": "", 
      "sexo": "",
      "dataNascimento": "",
      "distanciaMaxima": "",
      "faixaEtaria": "",
      "statusPerfil": "",
      "descricao": "",
      "filme": "",
      "musica": "",
      "serie": "",
      "anime": "",
      "ocupacao": "",
      "idPerfilFacebook": 1,
      "idUser": ""
    };
  }

  void _validateAndSaveProfile() async{
    final form = formKey.currentState;
    if(form.validate()){
      form.save();
      profile["idUser"] = userID;
      await HttpRequest().doCreate(urlToCreateProfile, profile).then((String isProfileCreated) {
        if(isProfileCreated == 'true'){
          Navigator.pop(context);
        }        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _getUserID();
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildProfileSettingsList(),
    );
  }

  Widget _buildAppBar(){
    return AppBar(
      title: Text('New Profile'),  
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
                _buildFormTextField('Name can\'t be empty', 'Name'),
                _buildFormTextField('Sex can\'t be empty', 'Sex'),
                _buildFormTextField('Birth Date can\'t be empty', 'Birth Date'),
                _buildFormTextField('Max Distance Date can\'t be empty', 'Max Distance'),
                _buildFormTextField('Age Range Date can\'t be empty', 'Age Range'),
                _buildFormTextField('Profile status can\'t be empty', 'Profile Status'),
                _buildFormTextField('Favorite Movie can\'t be empty', 'Favorite Movie'),
                _buildFormTextField('Favorite Music can\'t be empty', 'Favorite Music'),
                _buildFormTextField('Favorite TV Show can\'t be empty', 'Favorite TV Show'),
                _buildFormTextField('Favorite Anime can\'t be empty', 'Favorite Anime'),
                _buildFormTextField('Occupation can\'t be empty', 'Occupation'),
                _buildFormTextField('Description can\'t be empty', 'Description'),
                _buildCreateAccountButton(),
              ],
            ),
          )
        ),
      ),
    );
  }

  Widget _buildFormTextField(String error, String label){ 
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 32),
      child: TextFormField(        
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

  Widget _buildCreateAccountButton(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
      child: Container(
        height: 50,
        child: RaisedButton(
          onPressed: (){
            //_validateAndSaveProfile();
            print(this.userID);
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

}
import 'package:flutter/material.dart';
import 'package:socimee/controller/restApi.dart';
import 'package:socimee/utils/ColorConverter.dart';

class ProfileRegister extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new ProfileRegisterState();
}

class ProfileRegisterState extends State<ProfileRegister>{

  final formKey = new GlobalKey<FormState>();

  final String url = "http://192.168.0.178:8084/Socimee/socimee/profile/create";
  String name;
  String sex;
  String phone;
  DateTime birthDate;
  Map<String, dynamic> body;

  String idUser;

  @override
  Widget build(BuildContext context) {
    idUser = ModalRoute.of(context).settings.arguments;

    return _buildProfile();
  }

  void valideAndSubmit(){
    final form = formKey.currentState;
    if(form.validate()){
      form.save();

      body = {"nome":  name, "sexo": sex, "dataNascimento": birthDate.toString(), "idPerfilFacebook": "1", "idUser": idUser};

      Future.delayed(Duration(seconds: 2), (){
       HttpRequest().doCreate(url, body).then((String idProfile){
         if(idProfile.isNotEmpty){
            Navigator.of(context).pushNamed('/profilePersonality', arguments: idProfile);
         }
       });
      });
    }
  }

  Widget _buildProfile(){
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
        child: _buildForm(),
      ),
      resizeToAvoidBottomPadding: false,
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
              _buildNameField(),
              _buildSexField(),            
              _buildBirthField(),            
              _buildConfirmationButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameField(){
     return Container(
       margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
       child: TextFormField(
        maxLines: 1,
        decoration: InputDecoration(
          labelText: 'Name',
          labelStyle: TextStyle(color: Colors.white),
          prefixIcon: Icon(Icons.person, color: Colors.white),
        ),
        validator: (value) => value.isEmpty ? 'Name can\'t be empty' : null,
        onSaved: (value){
          name = value;
        },
       ),
     );
  }

  Widget _buildSexField(){
    return Row(
      children: <Widget>[
        _buildSexList('Male', 'M'),
        _buildSexList('Female', 'F'),
      ],
    );
  }

  Widget _buildSexList(String sexName, String sexValue){
    return Flexible(
      child: ListTile(
        title: Text(sexName),
        leading: Radio(
          activeColor: Colors.white,
          hoverColor: Colors.white,
          focusColor: Colors.white,
          value: sexValue, 
          groupValue: sex, 
          onChanged: (String value){
            setState(() {
              sex = value;
            });
          }
        ),
      ),
    );
  }

  Widget _buildBirthField(){
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
      width: 250,
      height: 40,
      child: RaisedButton(
        onPressed: (){
          _selectDate(context);
        },
        color: ColorConverter().backgroundFirstColor().withOpacity(0.7),        
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Text('Select Date of Birth', style: TextStyle(color: Colors.white),),        
      ),
    );
  }

  Widget _buildConfirmationButton(){
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
      width: 250,
      height: 40,
      child: RaisedButton(
        onPressed: (){
          valideAndSubmit();
        },
        color: ColorConverter().backgroundFirstColor().withOpacity(0.7),
        child: Text('Confirm', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async{
    final DateTime picked = await showDatePicker(
      builder: (BuildContext context, Widget child){
        return Theme(
          data: ThemeData.dark().copyWith(            
            primaryColor: const Color(0xFF4A5BF6),
            accentColor: const Color(0xFF4A5BF6),
          ), 
          child: child
        );
      },
      context: context, 
      initialDate: DateTime(2020), 
      firstDate: DateTime(1900), 
      lastDate: DateTime(2020),
    );

    if(picked != null){
      birthDate = picked;
    }
  }
}
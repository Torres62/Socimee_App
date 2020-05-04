import 'package:flutter/material.dart';
import 'package:socimee/controller/restApi.dart';

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

      //body = {"id": null, "nome":  name, "sexo": sex, "dataNascimento": birthDate, "phone": phone};
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
      body: SafeArea(
        child: _buildForm(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildForm(){
    return Center(
      child: Form(
        key: formKey,
        child: Container(          
          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Column(     
            mainAxisAlignment: MainAxisAlignment.center,                          
            children: <Widget>[
              _buildNameField(),
              _buildPhoneField(),
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
          hintText: 'Name',
          icon: Icon(Icons.person, color: Colors.deepPurple),
        ),
        validator: (value) => value.isEmpty ? 'Name can\'t be empty' : null,
        onSaved: (value){
          name = value;
        },
       ),
     );
  }

  Widget _buildPhoneField(){
     return Container(
       margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
       child: TextFormField(
         maxLines: 1,
         keyboardType: TextInputType.number,
         decoration: InputDecoration(
           hintText: 'Phone Number',
           icon: Icon(Icons.phone, color: Colors.deepPurple),
         ),
         validator: (value) => value.isEmpty ? 'Phone Number can\'t be empty' : null,
         onSaved: (value){
           phone = value;
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
        color: Colors.deepPurple,        
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
        color: Colors.deepPurple,
        child: Text('Confirm', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async{
    final DateTime picked = await showDatePicker(
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
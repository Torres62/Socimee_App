import 'package:flutter/material.dart';
import 'package:socimee/controller/restApi.dart';
import 'package:socimee/utils/ColorConverter.dart';

class ProfileDescription extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ProfileDescriptionState();
}

class ProfileDescriptionState extends State<ProfileDescription>{

  final formKey = GlobalKey<FormState>();
  final String url = "http://192.168.0.178:8084/Socimee/socimee/profile/updateDescription";

  String occupation;
  String food;
  String place;
  String description;
  String idProfile;

  Map<String, dynamic> body;

  void validateAndSubmit() async {
    final form = formKey.currentState;
    form.save();

    body = {"idProfile": idProfile, "ocupacao": occupation, "descricao": description};

    await  HttpRequest().doPut(url, body).then((String id){
      if(id != "false"){
      Navigator.of(context).pushNamed('/socimeeHome', arguments: idProfile);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    idProfile = ModalRoute.of(context).settings.arguments;
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
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildForm(){
    return Center(
      child: Container(
        margin: EdgeInsets.all(8),
        child: Form(
          key: formKey,
          child: Column(  
            mainAxisAlignment: MainAxisAlignment.center,  
            crossAxisAlignment: CrossAxisAlignment.stretch,        
            children: <Widget>[      
              _buildOccupationField(),
              _buildFoodField(),
              _buildPlaceField(),
              _buildDescriptionField(),
              _buildConfirmationButton(),
            ],          
          ),
        )
      ),
    );
  }

  Widget _buildOccupationField(){
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Text(
            'Type your Occupation',
            style: TextStyle(color: Colors.white),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Occupation',
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(Icons.computer, color: Colors.white),
            ),
            onSaved: (value){
              occupation = value;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFoodField(){
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Text(
            'Type your Favorite Food',
            style: TextStyle(color: Colors.white),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Food',
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(Icons.kitchen, color: Colors.white),
            ),
            onSaved: (value){
              food = value;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceField(){
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Text(
            'Type your Favorite Place',
            style: TextStyle(color: Colors.white),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Place',
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(Icons.landscape, color: Colors.white),
            ),
            onSaved: (value){
              place = value;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionField(){
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Text(
            'Describe Yourself',
            style: TextStyle(color: Colors.white),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Description',      
              labelStyle: TextStyle(color: Colors.white)        
            ),
            maxLength: 150,
            onSaved: (value){
              description = value;
            }
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationButton(){
    return Container(
      margin: EdgeInsets.fromLTRB(5, 20, 5, 0),
      width: 300,
      child: RaisedButton(
        onPressed: (){
          validateAndSubmit();
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: ColorConverter().backgroundFirstColor().withOpacity(0.7),
        child: Text('Confirm', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

}
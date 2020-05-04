import 'package:flutter/material.dart';
import 'package:socimee/controller/restApi.dart';

class UserInfo extends StatelessWidget{

  String idUser;
  bool isConfirmed = false;
  String url = "http://192.168.0.178:8084/Socimee/socimee/user/delete/";
  

  @override
  Widget build(BuildContext context) {  
    idUser = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: _buildBody(context),
      appBar: AppBar(),
    );
  }

  Widget _buildBody(BuildContext context){
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,          
          children: <Widget>[
            _buildUserConfigButton('', 'Change Email/Password', context),         
            _buildDelAndLogoutButton('Delete User', context), 
            _buildDelAndLogoutButton( 'Logout', context),    
          ],
        ),
      ),
    );
  }

  Widget _buildUserConfigButton(String route, String buttonText, BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 200,
        child: RaisedButton(        
          onPressed: (){
            Navigator.of(context).pushNamed(route);
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Text(buttonText, style: TextStyle(color: Colors.white)),
          color: Colors.deepPurple,
        ),
      ),
    );
  }

  Widget _buildDelAndLogoutButton(String buttonText, BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 200,
        child: RaisedButton(        
          onPressed: (){ 
            sendDeleteRequest(context);
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Text(buttonText, style: TextStyle(color: Colors.white)),
          color: Colors.deepPurple,
        ),
      ),
    );
  }

  void  sendDeleteRequest(BuildContext context){
    url = url + idUser;
    Future.delayed(Duration.zero, (){
      HttpRequest().doDelete(url).then((String idUser){
        if(idUser == "true"){
          Navigator.of(context).pushNamed('/home');
        } else{
          
        }
      });
    });
  }
  
}
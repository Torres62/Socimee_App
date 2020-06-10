import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socimee/controller/restApi.dart';
import 'package:socimee/utils/ColorConverter.dart';

class SelectProfile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SelectProfileState();
}

class SelectProfileState extends State<SelectProfile>{

  StreamController _profilesController;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  String url = "http://192.168.0.178:8084/Socimee/socimee/profile/readUserProfiles/";

  loadProfiles() async{
    await HttpRequest().getLogin().then((String idUser){
      url = url + idUser;
    });
    await HttpRequest().doGetUserProfiles(url).then((res){      
      _profilesController.add(res);
      return res;            
    });
  }

  @override
  void initState() {
    _profilesController = new StreamController();
    loadProfiles();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      appBar: _buildAppBar(),
    );
  }

  Widget _buildAppBar(){
    return AppBar(
      centerTitle: true,
      title: Text(
        'Profiles',
      ),
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

  Widget _buildBody(){
    return SafeArea(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildGridProfileList()
          ],
        ),
      ),
    );
  }

  Widget _buildGridProfileList(){
    return Expanded(
      child: StreamBuilder(
        initialData: [],
        stream: _profilesController.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print('Snapshot Data ${snapshot.data}');     
          return ListView(
            children: <Widget>[
              Text(
                snapshot.data.toString()
              ),
            ],
          );            
        }
      ),
    );
  }

}

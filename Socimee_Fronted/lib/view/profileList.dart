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

  String teste;
  var url;

  loadProfiles() async{
    await HttpRequest().getLogin().then((String idUser){
      url = "http://192.168.0.178:8084/Socimee/socimee/profile/readUserProfiles/" + idUser;
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
      floatingActionButton: _buildAddProfileButton(),
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
          return _buildProfilesList(snapshot);
        }
      ),
    );
  }

  Widget _buildProfilesList(AsyncSnapshot snapshot){
    return GridView.builder(
      itemCount: snapshot.data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
      itemBuilder: (context, index){
        var profile = snapshot.data[index];
        return _buildProfileContainer(profile);
      }
    );    
  }

  Widget _buildProfileContainer(var profile){
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/profileSettings', arguments: profile).then((value) {
          setState(() {
            loadProfiles();            
          });
        });
      },
      child: Container(          
        margin: EdgeInsets.fromLTRB(40, 30, 40, 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: ColorConverter().backgroundSecondColor()
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorConverter().backgroundSecondColor().withOpacity(0.8),
              ColorConverter().backgroundFirstColor().withOpacity(0.8)
            ],
          ),
        ),       
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GridTile(                                      
            child: Text(
              profile['nome'], 
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddProfileButton(){
    return FloatingActionButton(
      onPressed: (){
        Navigator.pushNamed(context, '/createNewProfile').then((value) { 
          setState(() {
            loadProfiles();
          });          
        });
      },
      backgroundColor: ColorConverter().backgroundSecondColor(),
      child: Icon(
        Icons.add,
        size: 30,
      ),
    );
  }

}

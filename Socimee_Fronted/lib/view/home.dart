import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:socimee/controller/restApi.dart';
import 'package:socimee/utils/ColorConverter.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home>{  
  String idProfile;
  String idUser;

  CardController controller;  

  StreamController _profilesController;

  bool isLoaded = false;

  final urlToMatch = 'http://192.168.0.178:8084/Socimee/socimee/profile/likeOrDeny';

  var url;

  void _loadProfilesToMatch() async{
    await HttpRequest().getProfile().then((String id) {
      idProfile = id;
    });

    await HttpRequest().getLogin().then((String idUser){      
      url = "http://192.168.0.178:8084/Socimee/socimee/profile/readUsersToMatchCurrentProfile/" + idProfile;      
    });

    await HttpRequest().doGetUserProfiles(url).then((res){      
      _profilesController.add(res);            
      return res;            
    });   
    isLoaded = true;
    setState(() {});
  }

  @override
  void initState() {  
    _profilesController = new StreamController();
    _loadProfilesToMatch();          
    super.initState();    
  }

  @override
  Widget build(BuildContext context) {    
    HttpRequest().getLogin().then((String id){
      idUser = id;
    });
    
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: _buildSocimeeList(),
        ),
        appBar: _buildAppBar(),
        drawer: _buildDrawer(),
      ),
    );
  }

  Widget _buildSocimeeList(){
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Expanded(
          child: StreamBuilder(
            initialData: [],
            stream: _profilesController.stream,
            builder: (context, snapshot){
              if(snapshot.data != null){
                return _buildTinderSwapCard(snapshot);
              } else{
                return Text(
                  'No profiles to match',
                  style: TextStyle(
                    color: Colors.black
                  ),
                );
              }
            }
          ),
        ),
      ),
    );
  }

  void _doDeny(String idProfileToMatch) async{  
    Map<String, dynamic> denyJson = {
      "likeOrDeny": "Deny",
    	"idProfile": idProfile,
	    "idProfileToMatch": idProfileToMatch
    };

    await HttpRequest().doPost(urlToMatch, denyJson).then((value) {
      print('Profile was denied');
    });
  }

  void _doLike(String idProfileToMatch) async{
    Map<String, dynamic> likeJson = {
      "likeOrDeny": "Like",
    	"idProfile": idProfile,
	    "idProfileToMatch": idProfileToMatch
    };

    await HttpRequest().doPost(urlToMatch, likeJson).then((value) {
      print('Profile was liked');
    });
  }

  Widget _buildTinderSwapCard(snapshot){        
    return !isLoaded ? Container(child: Center(child: CircularProgressIndicator())) : TinderSwapCard(                  
      orientation: AmassOrientation.BOTTOM,
      totalNum: snapshot.data.length,
      stackNum: 3,
      swipeEdge: 4.0,
      maxWidth: MediaQuery.of(context).size.width * 1,
      maxHeight: MediaQuery.of(context).size.width * 1,
      minWidth: MediaQuery.of(context).size.width * 0.9,
      minHeight: MediaQuery.of(context).size.width * 0.9,
      cardController: controller = CardController(),          
      swipeCompleteCallback:
          (CardSwipeOrientation orientation, int index) {
            var profile = snapshot.data[index];                
            var idProfileToMatch = profile['idProfile'].toString();
            switch (orientation) {
              case CardSwipeOrientation.LEFT:      
                _doDeny(idProfileToMatch); 
                break;
              case CardSwipeOrientation.RIGHT:
                _doLike(idProfileToMatch);                
                break;
              case CardSwipeOrientation.RECOVER:
                break;
              default:
                break;
            }
      },
      cardBuilder: (context, index) {
        var profile = snapshot.data[index];        
        return Container(          
          margin: EdgeInsets.fromLTRB(60, 30, 60, 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: ColorConverter().backgroundSecondColor()
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ColorConverter().backgroundSecondColor(),
                ColorConverter().backgroundFirstColor()
              ],
            ),
          ),       
          child: _buildProfileInfo(profile),
        );
      },            
    );
  }

  Widget _buildProfileInfo(profile){
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GridTile(                                      
              child: Text(
                'Name: ${profile['nome']}', 
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ),
        _buildDatas(64.0, 'Movie: ${profile['filme']}'),
        _buildDatas(110.0, 'Music: ${profile['musica']}'),
        _buildDatas(156.0, 'Tv Show: ${profile['serie']}'),
        _buildDatas(202.0, 'Anime: ${profile['anime']}'),
        _buildDescription(166.0, 'Description: ${profile['descricao']}'),
      ],
    );
  }

  Widget _buildDatas(double position, String textInfo){
    return Positioned(      
      top: position,        
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: GridTile(                                      
          child: Text(
            textInfo, 
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  Widget _buildDescription(double position, String textInfo){
    return Positioned(      
      bottom: position,        
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: GridTile(                                      
          child: Text(
            textInfo, 
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(){
    return Drawer(                  
      child: Container(
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
        child: ListView(
          children: <Widget>[
            DrawerHeader(            
              child: Text(
                'Socimee',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24
                ),
              )
            ),
            _buildAccountSettings(),
            _buildProfiles(),
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountSettings(){
  return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed('/userInfo').then((value) {
          setState(() {
            _loadProfilesToMatch();
          });
        });
      },
      child: Container(
        child: ListTile(
          leading: Icon(
            Icons.person,
            color: Colors.white,
          ),
          title: Text(
            'Account',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );  
  }

  Widget _buildProfiles(){
  return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed('/profilesList').then((value) {
          setState(() {
            _loadProfilesToMatch();
          });
        });
      },
      child: Container(
        child: ListTile(
          leading: Icon(
            Icons.people,
            color: Colors.white,
          ),
          title: Text(
            'Profiles',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );  
  }

  Widget _buildLogoutButton(){
  return GestureDetector(
      onTap: (){
        HttpRequest().doLogout().then((void id){
          Navigator.of(context).pushNamed('/signHome');
        });      
      },
      child: Container(
        child: ListTile(
          leading: Icon(
            Icons.exit_to_app,
            color: Colors.red,
          ),
          title: Text(
            'Logout',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );  
}

  Widget _buildAppBar(){
    return AppBar(
      elevation: 0,      
      iconTheme: IconThemeData(color: ColorConverter().backgroundSecondColor()),      
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed('/socimeeHome');
        },
        child: Icon(
          Icons.home
        ),
      ),  
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
          child: GestureDetector(
            onTap: (){
              
            },
            child: Icon(
              Icons.chat
            ),
          ),
        ),
      ],    
    );
  }

}
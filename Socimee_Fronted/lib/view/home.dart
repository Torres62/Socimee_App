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

  StreamController _profileController;

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
    return  Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: StreamBuilder(
          initialData: [],
          stream: _profileController.stream,
          builder: (context, snapshot){
            return _buildTinderSwapCard();
          }
        ),
      ),
    );
  }

  Widget _buildTinderSwapCard(){
    return TinderSwapCard(                  
      orientation: AmassOrientation.BOTTOM,
      totalNum: 6,
      stackNum: 3,
      swipeEdge: 4.0,
      maxWidth: MediaQuery.of(context).size.width * 1,
      maxHeight: MediaQuery.of(context).size.width * 1,
      minWidth: MediaQuery.of(context).size.width * 0.9,
      minHeight: MediaQuery.of(context).size.width * 0.9,
      cardBuilder: (context, index) {
        return Card(
          color: ColorConverter().textGreyColor(),
          child: Text('Rafa'),
        );
      },
      cardController: controller = CardController(),          
      swipeCompleteCallback:
          (CardSwipeOrientation orientation, int index) {
            switch (orientation) {
              case CardSwipeOrientation.LEFT:      
                print('left');
                break;
              case CardSwipeOrientation.RIGHT:
                print('right');
                break;
              case CardSwipeOrientation.RECOVER:
                break;
              default:
                break;
            }
      },
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
        Navigator.of(context).pushNamed('/userInfo');
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
        Navigator.of(context).pushNamed('/profilesList');
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
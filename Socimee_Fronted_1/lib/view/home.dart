import 'package:flutter/material.dart';
import 'package:socimee/view/chatList.dart';
import 'package:socimee/view/profileList.dart';
import 'package:socimee/view/socimeeList.dart';
import 'package:socimee/view/userInfo.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home>{

  int _selectedBottomBar = 0;
  
  String idProfile;
  String idUser;

  List<Widget> _children() => [
    SelectProfile(),
    SocimeeList(),
    ChatList(),  
  ];

  @override
  Widget build(BuildContext context) {
    idUser = ModalRoute.of(context).settings.arguments;
    final List<Widget> children = _children();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: children[_selectedBottomBar],
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
        appBar: _buildAppBar(),
      ),
    );
  }

  void _onItemTapped(int index){
    setState(() {
      _selectedBottomBar = index;
    });
  }

  Widget _buildBottomNavigationBar(){
    return BottomNavigationBar(
      backgroundColor: Colors.deepPurple,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.people, color: Colors.white),
          title: Text('Profiles', style: TextStyle(color: Colors.white)),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.white),    
          title: Text('Home', style: TextStyle(color: Colors.white)),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat, color: Colors.white),
          title: Text('Chat', style: TextStyle(color: Colors.white))
        ),
      ],
      currentIndex: _selectedBottomBar,
      onTap: _onItemTapped,
    );
  }

  Widget _buildAppBar(){
    return AppBar(
      automaticallyImplyLeading: false,
      title: GestureDetector(        
        onTap: (){
          Navigator.of(context).pushNamed('/userInfo', arguments: idUser);
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
          width: 40,
          height: 40,
          child: Icon(
            Icons.person, 
            color: Colors.white,
            size: 40,
          ),
        ),
      ),      
    );
  }

}
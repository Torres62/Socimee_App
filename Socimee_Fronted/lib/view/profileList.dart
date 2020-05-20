import 'package:flutter/material.dart';
import 'package:socimee/controller/restApi.dart';
import 'package:socimee/utils/ColorConverter.dart';

class SelectProfile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SelectProfileState();
}

class SelectProfileState extends State<SelectProfile>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildGridProfileList(),
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

  Widget _buildGridProfileList(){
    return Container(
      margin: EdgeInsets.all(64),      
      child: GridView.builder(      
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(32),      
        itemCount: 5,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4, 
          crossAxisSpacing: 4,
        ), 
        itemBuilder: (BuildContext context, int index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed('/profileConfiguration');
              },
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                color: Colors.transparent,
              ),
            ),
          );
        }
      ),
    );
  }

}

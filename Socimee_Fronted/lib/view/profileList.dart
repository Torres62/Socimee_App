import 'package:flutter/material.dart';
import 'package:socimee/controller/restApi.dart';

class SelectProfile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SelectProfileState();
}

class SelectProfileState extends State<SelectProfile>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildGridProfileList(),
    );
  }

  Widget _buildGridProfileList(){
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(32),      
      itemCount: 21,
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
            child: Container(
              color: Colors.blue,
              child: Text('$index'),
            ),
          ),
        );
      }
    );
  }

}

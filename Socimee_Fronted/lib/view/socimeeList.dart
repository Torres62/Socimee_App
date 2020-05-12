import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:socimee/controller/restApi.dart';

class SocimeeList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SocimeeListState();
}

class SocimeeListState extends State<SocimeeList>{

  CardController controller;
  String cardPosition;
  String idUser;

  @override
  Widget build(BuildContext context) {
    print(idUser);
    return Scaffold(
      body: SafeArea(
        child: _buildList(),
      ),
    );
  }

  Widget _buildList(){
    return  Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: TinderSwapCard(                  
          orientation: AmassOrientation.BOTTOM,
          totalNum: 6,
          stackNum: 3,
          swipeEdge: 4.0,
          maxWidth: MediaQuery.of(context).size.width * 0.9,
          maxHeight: MediaQuery.of(context).size.width * 0.9,
          minWidth: MediaQuery.of(context).size.width * 0.8,
          minHeight: MediaQuery.of(context).size.width * 0.8,
          cardBuilder: (context, index) {
            return Card(
              color: Colors.blue,
              child: Text('Rafa'),
            );
          },
          cardController: controller = CardController(),
          swipeUpdateCallback:
              (DragUpdateDetails details, Alignment align) {
            /// Get swiping card's alignment
            if (align.x < 0) {
              //Card is LEFT swiping
              cardPosition = 'Left';
            } else if (align.x > 0) {
              //Card is RIGHT swiping
              cardPosition = 'Right';
            }
          },
          swipeCompleteCallback:
              (CardSwipeOrientation orientation, int index) {
                print(cardPosition);
            /// Get orientation & index of swiped card!
          },
        ),
      ),
    );
  }
}
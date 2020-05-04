import 'package:flutter/material.dart';
import 'package:socimee/controller/restApi.dart';

class ProfilePersonality extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ProfilePersonalityState();
}

class ProfilePersonalityState extends State<ProfilePersonality>{

  String selectedMovie;
  String selectedMusic;
  String selectedTvShow;
  String selectedAnime;
  String idProfile;

  Map<String, dynamic> body;

  final String url = "http://192.168.0.178:8084/Socimee/socimee/profile/updatePersonality";

  final formKey = GlobalKey<FormState>();  

  void validateAndSubmit(){
    final form = formKey.currentState;
    if(form.validate()){
      form.save();

      body = {"idProfile": idProfile, "filme": selectedMovie, "musica": selectedMusic, "serie": selectedTvShow, "anime": selectedAnime};

      Future.delayed(Duration(seconds: 2), (){
       HttpRequest().doPut(url, body).then((String id){
         if(id != "false"){
            Navigator.of(context).pushNamed('/profileDescription', arguments: idProfile);
         }
       });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    idProfile = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: SafeArea(
        child: _buildForm(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildForm(){
    return Container(     
      child: Form(
        key: formKey,          
        child: Column(   
          mainAxisAlignment: MainAxisAlignment.center, 
          children: <Widget>[
            _buildMovieField(),             
            _buildMusicField(),            
            _buildTvShowField(),            
            _buildAnimeField(),
            _buildConfirmationButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieField(){
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Text(
            'Type your Favorite Movie',
            style: TextStyle(color: Colors.deepPurple),
          ),
          TextFormField(
            maxLines: 1,
            decoration: InputDecoration(
              icon: Icon(Icons.movie, color: Colors.deepPurple),
              hintText: 'Movie',
            ),
            validator: (value) => value.isEmpty ? 'Movie can\'t be empty' : null,
            onSaved: (value){
              selectedMovie = value; 
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMusicField(){
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Text(
            'Type your Favorite Music',
            style: TextStyle(color: Colors.deepPurple),
          ),
          TextFormField(
            maxLines: 1,
            decoration: InputDecoration(
              icon: Icon(Icons.music_note, color: Colors.deepPurple),
              hintText: 'Music',
            ),
            validator: (value) => value.isEmpty ? 'Music can\'t be empty' : null,
            onSaved: (value){
              selectedMusic = value; 
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTvShowField(){
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Text(
            'Type your Favorite TV Show',
            style: TextStyle(color: Colors.deepPurple),
          ),
          TextFormField(
            maxLines: 1,
            decoration: InputDecoration(
              icon: Icon(Icons.tv, color: Colors.deepPurple),
              hintText: 'TV Show',
            ),
            validator: (value) => value.isEmpty ? 'TV Show can\'t be empty' : null,
            onSaved: (value){
              selectedTvShow = value; 
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAnimeField(){
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Text(
            'Type your Favorite Anime',
            style: TextStyle(color: Colors.deepPurple),
          ),
          TextFormField(
            maxLines: 1,
            decoration: InputDecoration(
              icon: Icon(Icons.live_tv, color: Colors.deepPurple),
              hintText: 'Anime',
            ),
            validator: (value) => value.isEmpty ? 'Anime can\'t be empty' : null,
            onSaved: (value){
              selectedAnime = value; 
            },
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationButton(){
    return Container(
      margin: EdgeInsets.fromLTRB(16, 25, 16, 0),  
      child: RaisedButton(
        onPressed: (){
          validateAndSubmit();
        },
        color: Colors.deepPurple,
        child: Text('Confirm', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
  
}
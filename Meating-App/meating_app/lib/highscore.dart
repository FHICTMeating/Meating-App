import 'package:flutter/material.dart';

class HighScoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Highscore"),
      ),
      body: HighscoreForm(),
    );
  }
}

class HighscoreForm extends StatefulWidget {
  @override
  HighscoreFormState createState() => new HighscoreFormState();
}

class HighscoreFormState extends State<HighscoreForm> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: FlatButton(
        child: Text('Previous'),
         onPressed: (){
          Navigator.pushReplacementNamed(
                          context,
                          'quiz',
                        );
         }
      ),
    );
  }
}
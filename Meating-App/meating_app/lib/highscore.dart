import 'package:flutter/material.dart';
import './model/user.dart';
import './repository/userRepository.dart';

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
  List<User> scores = new List<User>();

  @override
  void initState() {
    UserRepository().selectAll().then((highscores){
      setState(() {
              this.scores = highscores;
            });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      Expanded(
        child: ListView.builder(
          itemCount: scores.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text((index + 1).toString() + '. ' + scores[index].name +
                  ': ' +
                  scores[index].score.toString()),
            );
          },
        ),
        flex: 6
      ),
      Expanded(
        child: Center(
          child: RaisedButton(
            child: Text('Terug naar menu'),
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                'start',
              );
            }),
          
      ),
      flex: 1
      )
    ]));
  }
}

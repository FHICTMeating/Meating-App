import 'package:flutter/material.dart';
import 'score.dart';

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
  final List<Score> scores = new List<Score>();

  @override
  void initState() {
    scores.add(new Score('Team A', 100));
    scores.add(new Score('Switch', 56));
    scores.add(new Score('Werkmaat', 2));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: scores.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
                scores[index].teamName + ': ' + scores[index].score.toString()),
          );
        },
      ),
      // FlatButton(
      //     child: Text('Previous'),
      //     onPressed: () {
      //       Navigator.pushReplacementNamed(
      //         context,
      //         'quiz',
      //       );
      //     }),
    );
  }
}

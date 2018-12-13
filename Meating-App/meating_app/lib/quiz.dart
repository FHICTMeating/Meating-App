import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz"),
      ),
      body: QuizForm(),
    );
  }
}

class QuizForm extends StatefulWidget {
  @override
  QuizFormState createState() => new QuizFormState();
}

class QuizFormState extends State<QuizForm> {
  final List<String> questions = new List<String>();
  double _value = 0;
  int _position = 0;


  @override
  void initState() {
    questions.add(
        'Hoeveel procent van alle verkochte smartphones in 2017 had Android als OS?');
    questions.add('Hoeveel procent van de aarde is bedekt in water?');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 30.0),
            Column(
              children: <Widget>[
                Text(questions[_position],
                    style: Theme.of(context).textTheme.title),
                SizedBox(height: 80.0),
                SizedBox(
                child: CircularProgressIndicator(
                  value: _value * 0.01,
                  strokeWidth: 20,
                ),
                height: 200,
                width: 200,
                ),
              ],
            ),
            SizedBox(height: 80.0),
            Text(_value.round().toString() + '%'),
            Slider(
              value: _value,
              min: 0.0,
              max: 100.0,
              onChanged: (double value) {
                setState(() {
                  _value = value;
                });
              },
            ),
            SizedBox(height: 30.0),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text('Vorige'),
                  onPressed: () {
                    if (_position - 1 < 0) {
                      return null;
                    } else {
                      setState(() {
                        _position--;
                        _value = 0;
                      });
                    }
                  },
                ),
                RaisedButton(
                  color: Theme.of(context).accentColor,
                  textColor: Colors.white,
                  splashColor: Colors.blueGrey,
                  child: Text('Volgende'),
                  onPressed: () {
                    if (_position + 1 == questions.length) {
                      Navigator.pushReplacementNamed(
                        context,
                        'highscore',
                      );
                    } else {
                      setState(() {
                        _position++;
                        _value = 0;
                        //send data to firebase
                      });
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

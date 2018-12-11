import 'package:flutter/material.dart';
import 'quiz.dart';
import 'highscore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Meating Quiz';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
      routes: <String, WidgetBuilder>{
        'start': (BuildContext context) => new MyApp(),
        'quiz': (BuildContext context) => new QuizScreen(),
        'highscore': (BuildContext context) => new HighScoreScreen(),
      },
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Image.asset('assets/images/meating-logo.png',
                    fit: BoxFit.cover),
              ),
              Text('Kies een naam voor je team',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Kies een naam voor je team';
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Navigator.pushReplacementNamed(
                        context,
                        'quiz',
                      );
                    }
                  },
                  child: Text('Starten'),
                  color: Theme.of(context).accentColor,
                  elevation: 4.0,
                  splashColor: Colors.blueGrey
                ),
              ),
            ],
          ),
        ));
  }
}

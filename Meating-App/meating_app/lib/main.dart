import 'package:flutter/material.dart';
import 'quiz.dart';
import 'highscore.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Meating Quiz';

    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        // Define the default Brightness and Colors
        brightness: Brightness.light,
        primaryColor: Colors.green[500],
        accentColor: Colors.green[600],

        // Define the default Font Family
        fontFamily: 'Montserrat',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
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
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  saveTeam(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('teamName', name);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(96.0),
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
                  style: Theme.of(context).textTheme.headline),
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Kies een naam voor je team';
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 64.0),
                child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        saveTeam(nameController.text);
                        Navigator.pushReplacementNamed(
                          context,
                          'quiz',
                        );
                      }
                    },
                    child: Text('Starten'),
                    color: Theme.of(context).accentColor,
                    textColor: Colors.white),
              ),
              SizedBox(height: 40,),
              RaisedButton(
                child: Text('Bekijk highscores'),
                onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          'highscore',
                        );
                    }
              )
            ],
          ),
        ));
  }
}

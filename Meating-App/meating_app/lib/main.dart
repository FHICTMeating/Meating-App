import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io' show Platform;
import 'quiz.dart';
import 'highscore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './repository/userRepository.dart';
import './repository/repository.dart';
import './model/user.dart';
import 'dart:convert';

FirebaseApp app;
  
void main() async {
  await FirebaseApp.configure(
      name: 'db2',
      options: Platform.isIOS
          ? const FirebaseOptions(
              googleAppID: '1:182815347842:ios:a0030deccf728cb7',
              databaseURL: 'https://meating-app-48b2e.firebaseio.com',
              gcmSenderID: '182815347842',
            )
          : const FirebaseOptions(
              googleAppID: '1:182815347842:android:a0030deccf728cb7',
              apiKey: 'AIzaSyCOWCfxNLpKHWjdBH0fB3WdfQ7Bb33pTjQ',
              databaseURL: 'https://meating-app-48b2e.firebaseio.com',
            ),
  );
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = '';	
    return MaterialApp(
      title: '',
      theme: ThemeData(
        // Define the default Brightness and Colors
        brightness: Brightness.dark,
        primaryColor: Colors.grey[800],
        accentColor: Colors.orange[800],

        // Define the default Font Family
        fontFamily: 'Furore',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 30.0),
          title: TextStyle(fontSize: 20),
          body1: TextStyle(fontSize: 14.0),
          button: TextStyle(fontSize: 20, color: Colors.white)
        ),
        buttonTheme: ButtonThemeData(
          minWidth: 300,
          height: 60,
          buttonColor: Colors.orange[700],
          disabledColor: Colors.orange[400],
          textTheme: ButtonTextTheme.normal,
          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
        )
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
      routes: <String, WidgetBuilder>{
        'start': (BuildContext context) => new QuizApp(),
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

  Repository userRepository;

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    userRepository = new UserRepository();
    super.initState();
  }

  saveTeam(String name) {
    SharedPreferences.getInstance()
    .then((prefs){
      userRepository.save({"name": name})
        .then((user){
          prefs.setString('user', jsonEncode(user));
        });
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 96),
        child: Center( 
          child: new Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Image.asset('assets/images/meating-logo.png',
                    fit: BoxFit.cover),
              ),
              Text('Vul je naam in',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Vul een naam in';
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
          ),
          ),
        ));
  }
}

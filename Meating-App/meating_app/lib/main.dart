import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io' show Platform;
import 'model/user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'quiz.dart';

FirebaseApp app;
  
void main() async{
  app = await FirebaseApp.configure(
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
        'start': (BuildContext context) => new QuizApp(),
        'quiz': (BuildContext context) => new QuizScreen(),
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
                    User user = new User("sdads");
                    final FirebaseDatabase database = FirebaseDatabase(app:app);
                    var userreference = database.reference().child("user");
                    userreference.push().set(user.toJson());
                    if (_formKey.currentState.validate()) {
                      Navigator.pushReplacementNamed(
                        context,
                        'quiz',
                      );
                    }
                  },
                  child: Text('Starten'),
                ),
              ),
            ],
          ),
        ));
  }
}

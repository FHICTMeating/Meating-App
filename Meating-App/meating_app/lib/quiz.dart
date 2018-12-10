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
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Text('Hoeveel procent van alle verkochte smartphones in 2017 had Android als OS? 87.7%', 
                style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 120.0),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Text('Previous'),
                  onPressed: (){
                    //show previous page
                  },
                ),
                RaisedButton(
                  child: Text('Next'),
                  onPressed: (){
                    //show next page
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
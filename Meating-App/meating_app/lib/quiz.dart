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
  double _value = 0;

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
                Text('Hoeveel procent van alle verkochte smartphones in 2017 had Android als OS?', 
                style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 80.0),
                CircularProgressIndicator(
                  value: _value * 0.01,
                ),
              ],
            ),
            SizedBox(height: 80.0),
            Text(_value.round().toString() + '%'),
            Slider(
              value: _value,
              min: 0.0,
              max: 100.0,
              onChanged: (double value){
                setState(() {
                  _value = value;
                });
              },
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
                  color: Theme.of(context).accentColor,
                  elevation: 4.0,
                  splashColor: Colors.blueGrey,
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
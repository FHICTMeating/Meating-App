import 'package:flutter/material.dart';
import 'piechart.dart';
import 'dart:math';
import 'package:angles/angles.dart';
import './model/question.dart';

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

class QuizFormState extends State<QuizForm> with SingleTickerProviderStateMixin{
  final List<Question> questions = new List<Question>();
  double _percentage = 55;
  int _position = 0;
  double _difference = 0;
  bool _showAnswer = false;

  Offset panPos = new Offset(0, 0);

  @override
  void initState() {
    questions.add(new Question(
        'Hoeveel procent van alle verkochte smartphones in 2017 had Android als OS?', 87.8));
    questions.add(new Question(
      'Hoeveel procent van de aarde is bedekt in water?', 70.0));

    super.initState();
    Animation<double> animation;
    var controller = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    var begin = _difference;
      animation = Tween<double>(begin: begin, end: 0).animate(controller)
      ..addListener(() {
        setState(() {
          _difference = animation.value;
        });
      });
 
    controller.forward();
  }

  double calculatePercentage(Offset pos1, Offset pos2) {
    Angle angle =
        Angle.fromRadians(atan2(pos2.dx - pos1.dx, pos2.dy - pos1.dy));
    double degrees = angle.degrees * (-1);
    if (degrees <= 0) degrees += 360;
    return (degrees / 360 * 100);
  }

  double calculateDifference(double answer, double guess){
    return answer - guess;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.0),
              Column(
                children: <Widget>[
                  // Text(questions[_position].question,
                  //     style: Theme.of(context).textTheme.title),
                  SizedBox(height: 80.0),
                  SizedBox(
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          RenderBox getBox = context.findRenderObject();
                          panPos = getBox.globalToLocal(details.globalPosition);
                          var center = new Offset(
                              context.size.width / 2, context.size.height / 2);
                          _percentage = calculatePercentage(panPos, center);
                          _difference = calculateDifference(questions[_position].awnser, _percentage);
                        });
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Stack(
                          alignment: FractionalOffset.center,
                          children: <Widget>[
                            Positioned.fill(
                              child: CustomPaint(
                                  foregroundPainter: PieChart(
                                      fillColor: Colors.green[700],
                                      backgroundColor: Colors.lightGreen,
                                      percentage: _percentage,
                                      difference: _difference,
                                      showingAnswer: _showAnswer)),
                            ),
                            Text(_percentage.round().toString() + '%',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white))
                          ]),
                    ),
                    height: 200,
                    width: 200,
                  ),
                ],
              ),
              SizedBox(height: 100.0),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Vorige'),
                    onPressed: () {
                      if (_position - 1 < 0) {
                        setState((){
                          _showAnswer = !_showAnswer;
                        });
                        return null;
                      } else {
                        setState(() {
                          _position--;
                          _percentage = 0;
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
                          _percentage = 0;
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
      ),
    );
  }
}

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

class QuizFormState extends State<QuizForm> with TickerProviderStateMixin {
  final List<Question> questions = new List<Question>();
  double _percentage = 0;
  int _position = 0;
  double _difference = 0;
  double _score = 0;
  String _niceAnswer = "Nice!";
  String _diffAnswer = "";

  bool _showAnswer = false;
  bool _canResume = false;
  bool _visible = false;

  String _buttonText = "Beantwoorden";

  Offset panPos = new Offset(0, 0);

  @override
  void initState() {
    questions.add(new Question(
        'Hoeveel procent van alle verkochte smartphones in 2017 had Android als OS?',
        88));
    questions.add(
        new Question('Hoeveel procent van de aarde is bedekt in water?', 70.0));

    super.initState();
  }

  double calculatePercentage(Offset pos1, Offset pos2) {
    Angle angle =
        Angle.fromRadians(atan2(pos2.dx - pos1.dx, pos2.dy - pos1.dy));
    double degrees = angle.degrees * (-1);
    if (degrees <= 0) degrees += 360;
    return (degrees / 360 * 100);
  }

  void setLabels() {
    if (_difference.round() == 0) {
      _visible = true;
      _niceAnswer = "Excellent!";
      _diffAnswer = "";
    } else if (_difference.round().abs() < 10) {
      _visible = true;
      _niceAnswer = "Nice!";
      _diffAnswer =
          " Slechts " + _difference.round().abs().toString() + "% ervan af!";
    } else if (_difference.round().abs() < 30){
      _visible = true;
      _niceAnswer = "Goedzo!";
      _diffAnswer = " Je zit er " + _difference.round().abs().toString() + "% ervan af.";
    }
  }

  void calculateScore(double difference){
    _score += 100 - difference.round().abs();
  }

  void answerQuestion() {
    _difference = calculateDifference(questions[_position].awnser, _percentage);
    calculateScore(_difference);
    setLabels();
    _showAnswer = true;

    _buttonText = "...";

    Animation<double> animation;
    var controller = AnimationController(
        duration: Duration(milliseconds: 5000), vsync: this);

    var end = _difference;
    animation = Tween<double>(begin: 0, end: end).animate(controller)
      ..addListener(() {
        setState(() {
          _difference = animation.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _canResume = true;
            _buttonText = "Verder";
          });
        }
      });

    controller.forward();
  }

  double calculateDifference(double answer, double guess) {
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
              Column(
                children: <Widget>[
                  Text(questions[_position].question,
                      style: Theme.of(context).textTheme.title),
                  SizedBox(height: 120),
                  IgnorePointer(
                    ignoring: _showAnswer || _canResume,
                    child: SizedBox(
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          setState(() {
                            RenderBox getBox = context.findRenderObject();
                            panPos =
                                getBox.globalToLocal(details.globalPosition);
                            var center = new Offset(context.size.width / 2,
                                context.size.height / 2);
                            _percentage = calculatePercentage(panPos, center);
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
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _visible
                      ? Text(_niceAnswer + _diffAnswer,
                          style: TextStyle(fontSize: 25))
                      : Container(),
                ],
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: Theme.of(context).accentColor,
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    child: Text(_buttonText),
                    onPressed: () {
                      if (_showAnswer && !_canResume) return null;

                      if (_canResume) {
                        setState(() {
                          _position++;
                          _percentage = 0;
                          _difference = 0;
                          _canResume = false;
                          _showAnswer = false;
                          _visible = false;
                          _buttonText = "Beantwoorden";
                        });
                      } else {
                        setState(() {
                          answerQuestion();
                          //send data to firebase
                        });
                      }

                      if (_position == questions.length) {
                        _position = 0;
                        _canResume = false;
                        Navigator.pushReplacementNamed(
                          context,
                          'highscore',
                        );
                      }
                    },
                  ),
                ],
              ),
              Text("Score: " + _score.round().toString()),
            ],
          ),
        ),
      ),
    );
  }
}

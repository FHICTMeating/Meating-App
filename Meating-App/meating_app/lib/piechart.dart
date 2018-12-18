import 'package:flutter/material.dart';
import 'dart:math'; 

class PieChart extends CustomPainter{

  Color fillColor;
  Color backgroundColor;
  Color differenceColor = Colors.red;

  double percentage;
  double difference = 0;

  bool showingAnswer = true;

  PieChart(
    {
      this.fillColor,
      this.backgroundColor,
      this.percentage,
      this.difference,
      this.showingAnswer,
    }
  );

  @override
  void paint(Canvas canvas, Size size) {

    Paint fill = new Paint();
    fill.color = this.fillColor;
    fill.style = PaintingStyle.fill;

    Paint back = new Paint();
    back.color = this.backgroundColor;
    back.style = PaintingStyle.fill;

    Paint diffFill = new Paint();
    diffFill.color = this.differenceColor;
    diffFill.style = PaintingStyle.fill;


    double arcAngle = 2 * pi * (percentage / 100);
    double diffAngle = 2 * pi * (difference / 100);

    Offset center  = new Offset(size.width/2, size.height/2);
    double radius  = min(size.width/2,size.height/2);

    canvas.drawCircle(
        center,
        radius,
        back
    );

    canvas.drawArc(
      new Rect.fromCircle(center: center,radius: radius), 
      -pi/2, 
      arcAngle, 
      true, 
      fill
    );

    if (showingAnswer){
      canvas.drawArc(
        new Rect.fromCircle(center: center,radius: radius), 
        -pi/2 + arcAngle, 
        diffAngle, 
        true, 
        diffFill
      );
    }
    
  }

  @override
  bool shouldRepaint(PieChart oldDelegate) {
    if (oldDelegate.difference != this.difference)
      return true;

    if (oldDelegate.percentage != this.percentage)
      return true;  

    return false;
  }
}
import 'package:flutter/material.dart';
import 'dart:math'; 

class PieChart extends CustomPainter{

  Color fillColor;
  Color backgroundColor;

  double percentage;

  PieChart(
    {
      this.fillColor,
      this.backgroundColor,
      this.percentage
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

    double arcAngle = 2 * pi * (percentage / 100);

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
    
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
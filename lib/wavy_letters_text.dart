library wavy_letters_text;

import 'dart:math' as math;
import 'package:flutter/material.dart';

class WavyLettersText extends StatefulWidget {
  const WavyLettersText(this.text);
  final String text;

  @override
  _WavyLettersTextState createState() => _WavyLettersTextState();
}

class _WavyLettersTextState extends State<WavyLettersText> with SingleTickerProviderStateMixin {

  AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(vsync: this);
    _animationController.duration = Duration(milliseconds: 3000);
    _animationController.addListener(() {setState(() {  });});
    _animationController.repeat();
  }
  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: CustomPaint(
        painter: MyTextPainter(widget.text, _animationController.value),
        size: Size(300,500),
      ),
    );
  }
}

class MyTextPainter extends CustomPainter {
  MyTextPainter(this.text, this.value);

  String text;
  double value;

  TextPainter _textPainter = new TextPainter(
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr);

  @override
  void paint(Canvas canvas, Size size) {

    var style = TextStyle(color: Colors.blue[800], fontSize: 32);

    for(int i = 0; i < text.length; i++){
      drawLetter(canvas, text[i]);
    }
  }

  bool b = true;
  double offset = 1;

  void drawLetter(Canvas canvas, String letter) {
    _textPainter.text = TextSpan(text: letter, style: TextStyle(color: Colors.blue[800], fontSize: 32));
    _textPainter.layout(minWidth: 0, maxWidth: double.maxFinite);

    final double d = _textPainter.maxIntrinsicWidth;
    double dy = offset * math.sin(2*math.pi*(-1 + 2*value));
    double dx = offset * 0.5 * math.cos(2*math.pi*(1 - 2*value));

    double sval = math.cos(2*math.pi*(-1 + 2*value) + math.pi);

    if(b) dy = -dy;
    if(b) dx = -dx;
    if(b) sval = -sval;
    b = !b;

    double s = 1 + 0.05*sval;

    //canvas.translate(-_textPainter.width/2, -_textPainter.height/2);
    canvas.scale(s, s);
    _textPainter.paint(canvas, Offset(dx, dy));
    canvas.scale(1/s, 1/s);
    //canvas.translate(_textPainter.width/2, _textPainter.height/2);

    canvas.translate(d, 0);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }

}
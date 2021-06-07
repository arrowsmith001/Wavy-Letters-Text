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
        size: Size(200,500),
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
      drawLetter(canvas, text[i], i, size);
    }
  }

  bool b = true;
  double offset = 1;

  double cursorX = 0;

  void drawLetter(Canvas canvas, String letter, int i, Size size) {
    _textPainter.text = TextSpan(text: letter, style: TextStyle(color: Colors.blue[800], fontSize: 32));
    _textPainter.layout(minWidth: 0, maxWidth: double.maxFinite);

    final double d = _textPainter.maxIntrinsicWidth;
    double dy = offset * (math.sin(2*math.pi*(-1 + 0.5 + 2*value) + i));
    double dx = offset * 0.5 * math.cos(2*math.pi*(1 - 2*value) + i);

    double scaleValue = math.cos(2*math.pi*(-1 + 2*value) + math.pi);

    if(b) dy = -dy;
    if(b) dx = -dx;
    if(b) scaleValue = -scaleValue;
    b = !b;

    double s = 1 + 0.05*scaleValue;

    // TODO: Implement scale change about the center of a letter glyph
    // double cx = size.width/2 + dx;
    // double cy = size.height/2 + dy;
    // canvas.translate(cx, cy);
    // canvas.scale(s, s);
    // _textPainter.paint(canvas, Offset(dx, dy));
    // canvas.scale(1/s, 1/s);
    // canvas.translate(-cx, -cy);

    _textPainter.paint(canvas, Offset(dx, dy));

    cursorX += d;
    if(cursorX >= size.width){
      canvas.translate(-cursorX + d, _textPainter.height);
      cursorX = 0;
    }
    else{
      canvas.translate(d, 0);
    }
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }

}
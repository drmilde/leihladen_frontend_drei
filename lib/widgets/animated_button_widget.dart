import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedButtonWidget extends StatefulWidget {
  GestureTapCallback? callback;
  Color? color;
  String text = "Warenkorb +";

  AnimatedButtonWidget({this.color, this.text = "Warenkorb+", this.callback});

  @override
  _AnimatedButtonWidgetState createState() => _AnimatedButtonWidgetState();
}

class _AnimatedButtonWidgetState extends State<AnimatedButtonWidget> {
  double width = 100;
  double height = 35;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.callback!();
          width = (width > 100) ? 100 : 110;
          height = (height > 35) ? 35 : 40;
        });
      },
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: new BorderRadius.only(
            topRight: new Radius.circular(10.0),
            bottomRight: new Radius.circular(10.0),
          ),
        ),
        curve: Curves.bounceInOut,
        duration: Duration(milliseconds: 200),
        width: width,
        height: height,
        onEnd: () {
          setState(() {
            width = 100;
            height = 35;
          });
        },
        child: Center(
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}

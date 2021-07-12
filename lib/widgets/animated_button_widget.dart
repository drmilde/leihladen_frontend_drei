import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leihladen_frontend_drei/widgets/animated_delete_button.dart';

class AnimatedButtonWidget extends StatefulWidget {
  GestureTapCallback? callback;
  Color? color;
  Widget? child = Container();
  double width = 100;

  AnimatedButtonWidget(
      {this.color, @required this.child, this.callback, this.width = 100});

  @override
  _AnimatedButtonWidgetState createState() => _AnimatedButtonWidgetState();
}

class _AnimatedButtonWidgetState extends State<AnimatedButtonWidget> {
  double width = 100;
  double height = 35;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    width = widget.width;
    height = 35;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.callback!();
          width = (width != widget.width) ? widget.width : widget.width * 1.1;
          height = (height > 35) ? 35 : 40;
        });
      },
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: new BorderRadius.only(
            topLeft: new Radius.circular(10.0),
            bottomLeft: new Radius.circular(10.0),
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
            width = widget.width;
            height = 35;
          });
        },
        child: Center(
          child: widget.child,
        ),
      ),
    );
  }
}

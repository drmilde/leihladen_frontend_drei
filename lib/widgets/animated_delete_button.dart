import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leihladen_frontend_drei/model/data_model.dart';

class AnimatedDeleteButton extends StatefulWidget {
  String inventarnummer = "unkown";
  late _AnimatedDeleteButtonState state;

  AnimatedDeleteButton(this.inventarnummer) {
     state = _AnimatedDeleteButtonState();
  }

  @override
  _AnimatedDeleteButtonState createState() => state;


  void update() {
    state.update();
  }
}

class _AnimatedDeleteButtonState extends State<AnimatedDeleteButton> {
  bool _doesContain = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _doesContain =
        DataModel.store.value.warenkorb.containsData(widget.inventarnummer);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DataModel.store.value.warenkorb.removeData(widget.inventarnummer);
        setState(() {
          _doesContain =
              DataModel.store.value.warenkorb.containsData(widget.inventarnummer);
        });
      },
      child: AnimatedCrossFade(
          firstChild: _makeContent("1"),
          secondChild: _makeContent("0"),
          crossFadeState: _doesContain
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: Duration(milliseconds: 200)),
    );
  }

  Widget _makeContent(String text) {
    return Container(
      width: 50,
      height: 35,
      //color: Colors.green,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          Icon(
            Icons.delete,
            size: 30,
          ),
        ],
      ),
    );
  }


  void update() {
    setState(() {
      _doesContain =
          DataModel.store.value.warenkorb.containsData(widget.inventarnummer);
    });
  }
}

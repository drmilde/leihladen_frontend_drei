import 'package:flutter/material.dart';

class AppDrawerEntryWidget extends StatelessWidget {
  String _text;
  String _assetName;
  Widget _screen;
  bool replace = true;
  bool showIcon = true;
  String screenName = "";

  //VoidCallback _callback;

  AppDrawerEntryWidget(this._text, this._assetName, this._screen,
      {this.replace = false, this.showIcon = true, this.screenName = ""});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (screenName != "") {
          Navigator.pop(context);
          Navigator.popUntil(
            context,
            ModalRoute.withName(screenName),
          );
        } else {
          if (replace) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => _screen));
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => _screen));
          }
        }
      },
      child: ListTile(
        title: Text(_text),
        //trailing: Icon(Icons.arrow_forward),
        leading: Container(
          height: 32,
          width: 32,
          //child: Image.asset(_assetName),
          child: showIcon ? Image.network(_assetName) : Container(),
        ),
      ),
    );
  }
}

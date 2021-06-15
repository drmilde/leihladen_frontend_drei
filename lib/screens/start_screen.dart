import 'package:flutter/material.dart';
import 'package:leihladen_frontend_drei/config/config.dart';
import 'package:leihladen_frontend_drei/model/data_model.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StartScreen"),
      ),
      body: Container(
        color: Colors.green,
        child: Text(configToJson(DataModel.config)),
      ),
    );
  }
}

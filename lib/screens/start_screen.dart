import 'package:flutter/material.dart';
import 'package:leihladen_frontend_drei/config/config.dart';
import 'package:leihladen_frontend_drei/model/data_model.dart';
import 'package:leihladen_frontend_drei/screens/katalog/katalog_screen.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StartScreen"),
      ),
      body: Container(
          color: Colors.green,
          child: Center(
            child: ElevatedButton(
              child: Text("KatalogScreen"),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (content) => KatalogScreen()));
              },
            ),
          )),
    );
  }
}

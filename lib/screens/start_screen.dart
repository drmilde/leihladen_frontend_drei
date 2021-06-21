import 'package:flutter/material.dart';
import 'package:leihladen_frontend_drei/config/config.dart';
import 'package:leihladen_frontend_drei/model/data_model.dart';
import 'package:leihladen_frontend_drei/screens/hauptseiten/haupt_seite_screen.dart';
import 'package:leihladen_frontend_drei/screens/hauptseiten/home_screen.dart';
import 'package:leihladen_frontend_drei/screens/katalog/katalog_screen.dart';
import 'package:leihladen_frontend_drei/screens/loader/server_auswahl_screen.dart';

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
            child: Column(
              children: [
                ElevatedButton(
                  child: Text("KatalogScreen"),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (content) => KatalogScreen()));
                  },
                ),
                ElevatedButton(
                  child: Text("HomeScreen"),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (content) => HomeScreen()));
                  },
                ),
                ElevatedButton(
                  child: Text("HauptSeiteScreen"),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (content) => HauptSeiteScreen()));
                  },
                ),
                ElevatedButton(
                  child: Text("ServerAuswahl"),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (content) => ServerAuswahlScreen()));
                  },
                ),
              ],
            ),
          )),
    );
  }
}

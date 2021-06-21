import 'package:flutter/material.dart';
import 'package:leihladen_frontend_drei/config/config.dart';
import 'package:leihladen_frontend_drei/config/screens/start_screen_config.dart';
import 'package:leihladen_frontend_drei/model/json_loader.dart';
import 'package:leihladen_frontend_drei/screens/hauptseiten/haupt_seite_screen.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  StartScreenConfig config = StartScreenConfig();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(config.getAppbarTitle()),
        backgroundColor: config.getPrimaryColor(),
      ),
      body: Container(
          color: Colors.white,
          child: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    settings: RouteSettings(name: "StartScreen"),
                    builder: (content) => HauptSeiteScreen()));
              },
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(config.getStartImageUrl(1)),
                  ),
                  Expanded(
                    child: Image.network(config.getStartImageUrl(2)),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

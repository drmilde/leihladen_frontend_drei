import 'package:flutter/material.dart';
import 'package:leihladen_frontend_drei/config/screens/start_screen_config.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(color: Colors.white),
          ),
          Container(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 90,
                            child: Image.network(config.getStartImageUrl(1)),
                          ),
                          Container(
                            height: 90,
                            child: Image.network(config.getStartImageUrl(3)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 200,
                        child: Image.network(config.getStartImageUrl(2)),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                child:
                                    Image.network(config.getSupportImageUrl(1)),
                              ),
                              Text(
                                config.getScreenVal("/content/text/support1"),
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 50,
                                child:
                                    Image.network(config.getSupportImageUrl(2)),
                              ),
                              Text(
                                config.getScreenVal("/content/text/support2"),
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(config.getStartText()),
                    ],
                  ),
                ),
              )),
          Expanded(
            child: Container(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:leihladen_frontend_drei/config/config.dart';
import 'package:leihladen_frontend_drei/config/persistence.dart';
import 'package:leihladen_frontend_drei/config/store.dart';
import 'package:leihladen_frontend_drei/model/data_model.dart';
import 'package:leihladen_frontend_drei/model/json_loader.dart';
import 'package:leihladen_frontend_drei/screens/start_screen.dart';
import 'package:leihladen_frontend_drei/widgets/dynamic_scaffold.dart';

class LoaderScreen extends StatefulWidget {
  @override
  _LoaderScreenState createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen> {
  Future<bool> loadConfigAndStore() async {
    // Store laden, bzw initialisieren
    String jsonString = await Persistence.load();
    jsonString = jsonString.trim();
    print("Storedaten... '${jsonString}'");
    if (jsonString != "") {
      Store s = storeFromJson(jsonString);
      DataModel.store = s;
    } else {
      Store s = Store.init();
      DataModel.store = s;
      bool saved = await Persistence.store(storeToJson(s));
      print("Store ist leer ... wurde initialisiert und persistiert");
    }

    // Config laden
    JsonLoader loader = new JsonLoader();
    Config config = await loader.loadUncompressedConfigFromServer();
    DataModel.setConfig(config);

    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicScaffold(
      drawer: Drawer(),
      appbar: AppBar(),
      showAppbar: false,
      fab: Container(),
      showFab: false,
      body: FutureBuilder(
        future: loadConfigAndStore(),
        // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          // Fall 1: keine Daten geladen
          if (snapshot.connectionState == ConnectionState.none &&
              snapshot.hasData == null) {
            return Container(
              color: Colors.red,
            );
          }
          // Fall 2: Daten werden noch geladen
          if (!snapshot.hasData) {
            return Container(
              color: Colors.blue,
            );
          } else {
            // Fall 3: Daten wurden geladen und können angezeigt werden
            bool result = snapshot.data as bool;
            return StartScreen();
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:leihladen_frontend_drei/config/persistence.dart';
import 'package:leihladen_frontend_drei/config/servers/server_liste.dart';
import 'package:leihladen_frontend_drei/config/store.dart';
import 'package:leihladen_frontend_drei/model/data_model.dart';
import 'package:leihladen_frontend_drei/model/json_loader.dart';
import 'package:leihladen_frontend_drei/screens/loader/server_auswahl_screen.dart';
import 'package:leihladen_frontend_drei/widgets/dynamic_scaffold.dart';

class BootLoaderScreen extends StatefulWidget {
  @override
  _BootLoaderScreenState createState() => _BootLoaderScreenState();
}

class _BootLoaderScreenState extends State<BootLoaderScreen> {
  Future<bool> loadServerlisteAndStore() async {
    // 0. Serverliste laden
    // TODO Serverliste von leihladen.org laden
    JsonLoader loader = new JsonLoader();
    ServerListe serverliste = await loader.loadUncompressedServerListe();
    print("Serverliste vom Bootserver geladen");
    DataModel.serverliste = serverliste;

    // 1. Store laden, bzw initialisieren
    String jsonString = await Persistence.load();
    jsonString = jsonString.trim();
    print("Storedaten lokal geladen");
    if (jsonString != "") {
      Store s = storeFromJson(jsonString);
      DataModel.store = s;
      DataModel.store.serverliste = serverliste;
    } else {
      Store s = Store.init();
      DataModel.store = s;
      bool saved = await Persistence.store(storeToJson(s));
      print("Store ist leer ... wurde initialisiert und persistiert");
    }

    return true;
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
        future: loadServerlisteAndStore(),
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
            return ServerAuswahlScreen();
          }
        },
      ),
    );
  }
}
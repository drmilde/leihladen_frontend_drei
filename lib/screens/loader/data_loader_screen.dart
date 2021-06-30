import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leihladen_frontend_drei/config/config.dart';
import 'package:leihladen_frontend_drei/config/persistence.dart';
import 'package:leihladen_frontend_drei/config/store.dart';
import 'package:leihladen_frontend_drei/katalog/katalog.dart';
import 'package:leihladen_frontend_drei/model/data_model_controller.dart';
import 'package:leihladen_frontend_drei/model/json_loader.dart';
import 'package:leihladen_frontend_drei/screens/start_screen.dart';
import 'package:leihladen_frontend_drei/widgets/dynamic_scaffold.dart';

class DataLoaderScreen extends StatefulWidget {
  final DataModelController dmc = Get.find();

  String dataServer = "";
  String dataPort = "";
  String dataPrepath = "";
  String dataDir = "";

  DataLoaderScreen({
    required this.dataServer,
    required this.dataPort,
    required this.dataPrepath,
    required this.dataDir,
  }) {
    dmc.prePath = this.dataPrepath;
  }

  @override
  _DataLoaderScreenState createState() => _DataLoaderScreenState();
}

class _DataLoaderScreenState extends State<DataLoaderScreen> {
  final DataModelController dmc = Get.find();

  Future<bool> loadConfigAndCatalog() async {
    // 1. try loading Store
    String jsonString = await Persistence.load();
    jsonString = jsonString.trim();
    print("Storedaten lokal geladen");
    if (jsonString != "") {
      Store s = storeFromJson(jsonString);
      dmc.store.value = s;
      //DataModel.store.serverliste = serverliste;
    } else {
      Store s = Store.init();

      dmc.store.value = s;
      bool saved = await Persistence.store(storeToJson(s));
      print("Store ist leer ... wurde initialisiert und persistiert");
    }

    // 2. Config laden
    JsonLoader loader = new JsonLoader();
    Config config = await loader.loadUncompressedConfigFromServer(
      dataServer: widget.dataServer,
      dataPort: widget.dataPort,
      dataPrepath: widget.dataPrepath,
      dataDir: widget.dataDir,
      configFileName: "config.json",
    );
    dmc.setConfig(config);

    // 3. load the katalog
    Katalog catalog = await loader.loadUncompressedCatalogDataFromServer(
      dataServer: widget.dataServer,
      dataPort: widget.dataPort,
      dataPrepath: widget.dataPrepath,
      dataDir: widget.dataDir,
      catalogFileName: "katalog.json",
    );
    dmc.katalog = catalog;
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
        future: loadConfigAndCatalog(),
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

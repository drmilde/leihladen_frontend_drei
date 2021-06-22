import 'package:flutter/material.dart';
import 'package:leihladen_frontend_drei/config/config.dart';
import 'package:leihladen_frontend_drei/katalog/katalog.dart';
import 'package:leihladen_frontend_drei/model/data_model.dart';
import 'package:leihladen_frontend_drei/model/json_loader.dart';
import 'package:leihladen_frontend_drei/screens/start_screen.dart';
import 'package:leihladen_frontend_drei/widgets/dynamic_scaffold.dart';

class DataLoaderScreen extends StatefulWidget {
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
   DataModel.prePath = this.dataPrepath;
  }

  @override
  _DataLoaderScreenState createState() => _DataLoaderScreenState();
}

class _DataLoaderScreenState extends State<DataLoaderScreen> {
  Future<bool> loadConfigAndCatalog() async {
    // 2. Config laden
    JsonLoader loader = new JsonLoader();
    Config config = await loader.loadUncompressedConfigFromServer(
      dataServer: widget.dataServer,
      dataPort: widget.dataPort,
      dataPrepath: widget.dataPrepath,
      dataDir: widget.dataDir,
      configFileName: "config.json",
    );
    DataModel.setConfig(config);

    // 3. load the katalog
    Katalog catalog = await loader.loadUncompressedCatalogDataFromServer(
      dataServer: widget.dataServer,
      dataPort: widget.dataPort,
      dataPrepath: widget.dataPrepath,
      dataDir: widget.dataDir,
      catalogFileName: "katalog.json",
    );
    DataModel.katalog = catalog;

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

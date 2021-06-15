import 'package:flutter/material.dart';
import 'package:leihladen_frontend_drei/katalog/eintrag.dart';
import 'package:leihladen_frontend_drei/katalog/katalog.dart';
import 'package:leihladen_frontend_drei/model/json_loader.dart';
import 'package:leihladen_frontend_drei/widgets/dynamic_scaffold.dart';

class KatalogScreen extends StatelessWidget {
  JsonLoader loader = JsonLoader();

  @override
  Widget build(BuildContext context) {
    return DynamicScaffold(
      drawer: _buildContent(),
      showDrawer: false,
      appbar: AppBar(
        title: Text("Katalogliste"),
      ),
      fab: _buildContent(),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Container(
      child: FutureBuilder(
        future: loader.loadUncompressedCatalogDataFromServer(),
        // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<Katalog> snapshot) {
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
            Katalog catalog = snapshot.data as Katalog;
            return _buildListView(catalog);
          }
        },
      ),
    );
  }

  Widget _buildListView(Katalog catalog) {
    return ListView.builder(
        itemCount: catalog.data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildCard(catalog.data[index]),
          );
        });
  }

  Widget _buildCard(Eintrag entry) {
    return Container(
            height: 100,
            color: Colors.black12,
            child: Text(entry.bezeichnung),
          );
  }
}

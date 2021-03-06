import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leihladen_frontend_drei/config/screens/katalog_screen_config.dart';
import 'package:leihladen_frontend_drei/katalog/eintrag.dart';
import 'package:leihladen_frontend_drei/katalog/katalog.dart';
import 'package:leihladen_frontend_drei/model/data_model_controller.dart';
import 'package:leihladen_frontend_drei/widgets/entry_card_widget.dart';

class KatalogFilteredListWidget extends StatefulWidget {
  int kategorie = 0;
  String title = "HEADER";
  late _KatalogFilteredListWidgetState kataloFilteredState;

  KatalogFilteredListWidget({this.kategorie = 0, this.title = "HEADER"}) {
    kataloFilteredState = new _KatalogFilteredListWidgetState();
  }

  @override
  _KatalogFilteredListWidgetState createState() => kataloFilteredState;

  void setSearchTerm(String term) {
    kataloFilteredState.setSearchTerm(term);
  }

  void setSortState(int state) {
    kataloFilteredState.setSortState(state);
  }
}

class _KatalogFilteredListWidgetState extends State<KatalogFilteredListWidget> {
  final DataModelController dmc = Get.find();

  Katalog catalog = new Katalog();
  KatalogScreenConfig config = new KatalogScreenConfig();
  int sortState = 0; // no sorting
  String term = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        //future: loader.loadUncomproessedCatalogDataFromServer(),
        future: dmc.getKatalog(),
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
            // Fall 3: Daten wurden geladen und k??nnen angezeigt werden
            catalog = snapshot.data as Katalog;
            if (sortState == 0) {
              catalog.sortAscending();
            }
            if (sortState == 1) {
              catalog.sortDescending();
            }
            if (sortState == 2) {
              catalog.sortInventarnummer();
            }
            return _buildListView(catalog);
          }
        },
      ),
    );
  }

  Widget _buildListView(Katalog catalog) {
    List<Widget> liste = [];
    liste.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: config.getPrimaryColor(),
        height: 32,
        width: double.infinity,
        child: Center(
          child: Text(
            widget.title,
            style: GoogleFonts.nunito(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    ));

    List<Eintrag> dataInKategorie = catalog.filterKategorie(widget.kategorie);
    List<Eintrag> filtered = search(dataInKategorie, term);

    String alphabet = "";
    bool left = true;
    filtered.forEach((e) {
      String anfangsbuchstabe = e.bezeichnung.toLowerCase()[0];
      if ((sortState == 0) || (sortState == 1)) {
        if (anfangsbuchstabe != alphabet) {
          alphabet = anfangsbuchstabe;
          Widget w = _createAlphabetHeader(alphabet);
          liste.add(w);
        }
      }
      Widget w = Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildCard(e, left: left),
      );
      liste.add(w);
      left = !left;
    });

    return ListView.builder(
        itemCount: liste.length,
        itemBuilder: (context, index) {
          return liste[index];
        });
  }

  List<Eintrag> search(List<Eintrag> dataInKategorie, String term) {
    List<Eintrag> filtered = dataInKategorie.where((e) {
      String all =
          (e.bezeichnung + e.inventarnummer + e.beschreibung).toLowerCase();
      return all.contains(term.toLowerCase());
    }).toList();

    return filtered;
  }

  Widget _createAlphabetHeader(String alphabet) {
    return Container(
      width: double.infinity,
      height: 24,
      decoration: BoxDecoration(
        border: new Border.all(
          color: Colors.black12,
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      child: Center(
          child: Text(
        alphabet.toUpperCase(),
        textAlign: TextAlign.center,
        style: GoogleFonts.nunito(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      )),
    );
  }

  Widget _buildCard(Eintrag entry, {bool left = true}) {
    if (entry.bezeichnung.length >= 45) {
      return _verybigCard(entry, left: left);
    }
    if (entry.bezeichnung.length >= 28) {
      return _bigCard(entry, left: left);
    } else {
      return _smallCard(entry, left: left);
    }
  }

  Widget _verybigCard(Eintrag entry, {bool left = true}) {
    return EntryCardWidget(
      entry,
      height: 410,
      left: left,
    );
  }

  Widget _bigCard(Eintrag entry, {bool left = true}) {
    return EntryCardWidget(
      entry,
      height: 380,
      left: left,
    );
  }

  Widget _smallCard(Eintrag entry, {bool left = true}) {
    return EntryCardWidget(
      entry,
      height: 360,
      left: left,
    );
  }

  /// external config

  void setSearchTerm(String term) {
    setState(() {
      this.term = term;
    });
  }

  void setSortState(int state) {
    setState(() {
      sortState = state;
    });
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leihladen_frontend_drei/config/screens/katalog_screen_config.dart';
import 'package:leihladen_frontend_drei/katalog/eintrag.dart';
import 'package:leihladen_frontend_drei/katalog/katalog.dart';
import 'package:leihladen_frontend_drei/model/data_model.dart';
import 'package:leihladen_frontend_drei/screens/katalog/katalog_detail_screen.dart';

class KatalogFilteredListWidget extends StatefulWidget {
  int kategorie = 0;
  late _KatalogFilteredListWidgetState kataloFilteredState;

  KatalogFilteredListWidget({this.kategorie = 0}) {
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
  Katalog catalog = new Katalog();
  KatalogScreenConfig config = new KatalogScreenConfig();
  int sortState = 0; // no sorting
  String term = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        //future: loader.loadUncomproessedCatalogDataFromServer(),
        future: DataModel.getKatalog(),
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
    //liste.add(_makeListHeader());

    List<Eintrag> dataInKategorie = catalog.filterKategorie(widget.kategorie);
    List<Eintrag> filtered = search(dataInKategorie, term);

    String alphabet = "";

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
        child: _buildCard(e),
      );
      liste.add(w);
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

  Widget _buildCard(Eintrag entry) {
    if (entry.bezeichnung.length >= 45) {
      return _verybigCard(entry);
    }
    if (entry.bezeichnung.length >= 28) {
      return _bigCard(entry);
    } else {
      return _smallCard(entry);
    }
  }

  Widget _verybigCard(Eintrag entry) {
    return _buildSizedCard(entry, height: 410);
  }

  Widget _bigCard(Eintrag entry) {
    return _buildSizedCard(entry, height: 380);
  }

  Widget _smallCard(Eintrag entry) {
    return _buildSizedCard(entry, height: 360);
  }

  Widget _buildSizedCard(Eintrag entry, {double height = 340}) {
    return Center(
      child: Container(
        height: height,
        //width: MediaQuery.of(context).size.width /2,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.black12,
          gradient: new LinearGradient(
            colors: [Colors.black12, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          border: new Border.all(
            color: config.getPrimaryColor(),
            width: 1.0,
            style: BorderStyle.solid,
          ),
          borderRadius: new BorderRadius.only(
            topLeft: new Radius.circular(20.0),
            topRight: new Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                entry.bezeichnung,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => KatalogDetailScreen(
                           entry: entry,
                          )));
                },
                child: Container(
                  height: 240,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          config.getKatalogImageUrl(entry.bilder[0])),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.black12,
                    gradient: new LinearGradient(
                      colors: [Colors.black12, Colors.white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    border: new Border.all(
                        color: Colors.black12,
                        width: 1.0,
                        style: BorderStyle.solid),
                    borderRadius: new BorderRadius.only(
                      topLeft: new Radius.circular(20.0),
                      topRight: new Radius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ),
            _WarenkorbRow(),
            //Text(entry.beschreibung),
            //Text(entry.inventarnummer),
          ],
        ),
      ),
    );
  }

  Widget _WarenkorbRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildWarenkorbButton(),
          Row(
            children: [
              Text(
                "0",
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWarenkorbButton() {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: config.getPrimaryColor(),
        borderRadius: new BorderRadius.only(
          topRight: new Radius.circular(10.0),
          bottomRight: new Radius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {},
          child: Text(
            "Warenkorb +",
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ),
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

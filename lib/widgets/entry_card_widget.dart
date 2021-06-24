import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leihladen_frontend_drei/config/screens/katalog_screen_config.dart';
import 'package:leihladen_frontend_drei/katalog/eintrag.dart';
import 'package:leihladen_frontend_drei/model/data_model.dart';
import 'package:leihladen_frontend_drei/screens/katalog/katalog_detail_screen.dart';

class EntryCardWidget extends StatelessWidget {
  KatalogScreenConfig config = new KatalogScreenConfig();
  Eintrag entry;
  double height;

  EntryCardWidget(this.entry, {this.height = 340});

  @override
  Widget build(BuildContext context) {
    return _buildSizedCard(context, entry, height: this.height);
  }

  Widget _buildSizedCard(BuildContext context, Eintrag entry,
      {double height = 340}) {
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
            _WarenkorbRow(entry),
            //Text(entry.beschreibung),
            //Text(entry.inventarnummer),
          ],
        ),
      ),
    );
  }

  Widget _WarenkorbRow(Eintrag entry) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildWarenkorbButton(entry),
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
                onPressed: () {
                  // TODO delte from warenkorb
                },
                icon: Icon(Icons.delete),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWarenkorbButton(Eintrag entry) {
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
          onTap: () {
            DataModel.store.warenkorb.addData(entry.inventarnummer);
          },
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
}

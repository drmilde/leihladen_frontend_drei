import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leihladen_frontend_drei/config/screens/katalog_screen_config.dart';
import 'package:leihladen_frontend_drei/katalog/eintrag.dart';
import 'package:leihladen_frontend_drei/screens/katalog/katalog_detail_screen.dart';
import 'package:leihladen_frontend_drei/widgets/warenkorb_row_widget.dart';



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
            //_WarenkorbRow(entry),
            WarenkorbRowWidget(entry),
          ],
        ),
      ),
    );
  }
}

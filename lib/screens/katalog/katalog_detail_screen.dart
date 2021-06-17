import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leihladen_frontend_drei/config/screens/katalog_screen_config.dart';
import 'package:leihladen_frontend_drei/katalog/eintrag.dart';
import 'package:leihladen_frontend_drei/screens/start_screen.dart';
import 'package:leihladen_frontend_drei/widgets/app_drawer_widget.dart';
import 'package:leihladen_frontend_drei/widgets/dynamic_scaffold.dart';

class KatalogDetailScreen extends StatelessWidget {
  KatalogScreenConfig config = new KatalogScreenConfig();
  String title = "Details";
  String inventarnummer = "";
  late Eintrag entry;

  KatalogDetailScreen({required this.entry});

  @override
  Widget build(BuildContext context) {
    return DynamicScaffold(
      drawer: Container(),
      showDrawer: false,
      appbar: AppBar(
        backgroundColor: config.getPrimaryColor(),
        title: Text(entry.bezeichnung),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.sort),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          )
        ],
      ),
      showAppbar: false,
      fab: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => StartScreen()));
        },
        child: Text("W+", style: TextStyle(color: Colors.white)),
        backgroundColor: config.getPrimaryColor(),
      ),
      showFab: true,
      body: _buildContent(context, entry),
    );
  }

  Widget _buildContent(BuildContext context, Eintrag entry) {
    return Scaffold(
      //endDrawer: AppDrawerWidget(),
      body: CustomScrollView(
        key: key,
        slivers: [
          SliverAppBar(
            centerTitle: true,
            pinned: true,
            expandedHeight: 400,
            backgroundColor: config.getPrimaryColor(),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                entry.bezeichnung.substring(
                  0,
                  min(entry.bezeichnung.length, 30),
                ),
              ),
              background: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 234,
                  width: 500,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        config.getKatalogImageUrl(entry.bilder[0])),
                  )),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildRow("Bezeichnung", entry.bezeichnung),
                  SizedBox(
                    height: 16,
                  ),
                  _buildRow("Beschreibung", entry.beschreibung),
                  SizedBox(
                    height: 16,
                  ),
                  _buildRow("Inventarnummer", entry.inventarnummer),
                  SizedBox(
                    height: 8,
                  ),
                  _buildRow("Dimension", entry.dimension),
                  SizedBox(
                    height: 8,
                  ),
                  _buildRow("Gewicht", entry.gewicht),
                  SizedBox(
                    height: 8,
                  ),
                  _buildRow("Hersteller", entry.hersteller),
                  SizedBox(
                    height: 8,
                  ),
                  _buildRow("Kaution", entry.kaution),
                  SizedBox(
                    height: 8,
                  ),
                  _buildRow("Kosten", entry.kosten),
                  SizedBox(
                    height: 8,
                  ),
                  _buildRow("Kleinteil", entry.kleinteil),
                  SizedBox(
                    height: 8,
                  ),
                  _buildRow("Lieferant", entry.lieferantenname),
                  SizedBox(
                    height: 8,
                  ),
                  _buildRow("Aktivdatum", entry.aktivdatum),
                  SizedBox(
                    height: 8,
                  ),
                  _buildRow("Typ", entry.typ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String caption, String text, {double width = 250}) {
    double fontSize = 16;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          caption,
          style: GoogleFonts.nunito(
              fontSize: fontSize, fontWeight: FontWeight.bold),
        ),
        Container(
          width: width,
          child: Text(
            text,
            textAlign: TextAlign.justify,
            style: GoogleFonts.nunito(
              fontSize: fontSize,
            ),
          ),
        ),
      ],
    );
  }
}

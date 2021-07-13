import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leihladen_frontend_drei/config/screens/katalog_screen_config.dart';
import 'package:leihladen_frontend_drei/katalog/eintrag.dart';
import 'package:leihladen_frontend_drei/model/data_model_controller.dart';
import 'package:leihladen_frontend_drei/screens/ausleihen/warenkorb_screen.dart';
import 'package:leihladen_frontend_drei/widgets/animated_button_widget.dart';
import 'package:leihladen_frontend_drei/widgets/dynamic_scaffold.dart';

class KatalogDetailScreen extends StatelessWidget {
  final DataModelController dmc = Get.find();
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
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => WarenkorbScreen()));
            },
            icon: Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      showAppbar: false,
      fab: AnimatedButtonWidget(
        color: config.getPrimaryColor(),
        child: Text(
          "+",
          textAlign: TextAlign.center,
          style: GoogleFonts.nunito(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
        callback: () {
          dmc.warenkorbAddData(entry.inventarnummer);
        },
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
            centerTitle: false,
            pinned: true,
            expandedHeight: 300,
            backgroundColor: config.getPrimaryColor(),
            actions: [
              IconButton(
                onPressed: () {
                  // TODO show image popup
                },
                icon: Icon(Icons.add_box_outlined),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WarenkorbScreen()));
                },
                icon: Icon(Icons.shopping_cart_outlined),
              ),
            ],
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
            child: _buildBeschreibung(entry.beschreibung),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildRow(
                    "Bezeichnung",
                    entry.bezeichnung,
                    greyBackground: true,
                  ),
                  _smallVerticalGap(),
                  _buildRow("Inventarnummer", entry.inventarnummer),
                  _smallVerticalGap(),
                  _buildRow("Dimension", entry.dimension),
                  _smallVerticalGap(),
                  _buildRow("Gewicht", entry.gewicht),
                  _smallVerticalGap(),
                  _buildRow("Hersteller", entry.hersteller),
                  _smallVerticalGap(),
                  _buildRow("Kaution", entry.kaution),
                  _smallVerticalGap(),
                  _buildRow("Kosten", entry.kosten),
                  _smallVerticalGap(),
                  _buildRow("Kleinteil", entry.kleinteil),
                  _smallVerticalGap(),
                  _buildRow("Lieferant", entry.lieferantenname),
                  _smallVerticalGap(),
                  _buildRow("Aktivdatum", entry.aktivdatum),
                  _smallVerticalGap(),
                  _buildRow("Typ", entry.typ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _smallVerticalGap() {
    return SizedBox(
      height: 8,
    );
  }

  Widget _buildBeschreibung(String beschreibung) {
    double fontSize = 14;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Beschreibung",
            style: GoogleFonts.nunito(
                fontSize: fontSize, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            //width: width,
            child: Text(
              beschreibung,
              textAlign: TextAlign.justify,
              style: GoogleFonts.nunito(
                fontSize: fontSize,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(
    String caption,
    String text, {
    double width = 200,
    bool greyBackground = false,
  }) {
    double fontSize = 14;
    return Container(
      color: greyBackground ? Colors.black12 : Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            caption,
            style: GoogleFonts.nunito(
                fontSize: fontSize, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              width: width,
              child: Text(
                (text == "") ? "--" : text,
                textAlign: TextAlign.justify,
                style: GoogleFonts.nunito(
                  fontSize: fontSize,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leihladen_frontend_drei/config/screens/fragen_screen_config.dart';
import 'package:leihladen_frontend_drei/screens/start_screen.dart';
import 'package:leihladen_frontend_drei/widgets/dynamic_scaffold.dart';

class FragenScreen extends StatelessWidget {
  FragenScreenConfig config = new FragenScreenConfig();
  String title = "Fragen";
  String beschreibung = "Lorem ipsum dolor sit amet, consetetur"
      " sadipscing elitr, sed diam nonumy eirmod tempor"
      " invidunt ut labore et dolore magna aliquyam erat,"
      " sed diam voluptua. At vero eos et accusam et justo"
      " duo dolores et ea rebum. Stet clita kasd gubergren,"
      " no sea takimata sanctus est Lorem ipsum dolor sit amet."
      " Lorem ipsum dolor sit amet, consetetur sadipscing elitr,"
      " sed diam nonumy eirmod tempor invidunt ut labore et dolore"
      " magna aliquyam erat, sed diam voluptua. At vero eos et"
      " accusam et justo duo dolores et ea rebum. Stet clita"
      " kasd gubergren, no sea takimata sanctus est"
      " Lorem ipsum dolor sit amet.";
  String imageUrl =
      "http://medsrv.informatik.hs-fulda.de/leihladenapp/data/config/leihladenfulda/boot/nackt.jpg";
  String inventarnummer = "";

  FragenScreen();

  @override
  Widget build(BuildContext context) {
    return DynamicScaffold(
      drawer: Container(),
      showDrawer: false,
      appbar: AppBar(
        backgroundColor: config.getPrimaryColor(),
        title: Text(title),
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
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
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
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.clear),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.save_outlined),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.shopping_bag_outlined),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  title.substring(
                    0,
                    min(title.length, 30),
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
                            //config.getKatalogImageUrl("http://hosted.met-art.com/Full_met-art_ESH_5_617/full/met-art_ESH_5_1.jpg"),
                            imageUrl,
                          )),
                    ),
                  ),
                ),
              )),
          SliverToBoxAdapter(
            child: _buildBeschreibung(beschreibung +
                beschreibung +
                beschreibung +
                beschreibung +
                beschreibung),
          ),
        ],
      ),
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
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leihladen_frontend_drei/config/screens/laden_info_screen_config.dart';
import 'package:leihladen_frontend_drei/screens/start_screen.dart';
import 'package:leihladen_frontend_drei/widgets/dynamic_scaffold.dart';

class LadenInfoScreen extends StatelessWidget {
  LadenInfoScreenConfig config = new LadenInfoScreenConfig();
  String title = "LadenInfo";
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

  LadenInfoScreen();

  @override
  Widget build(BuildContext context) {
    return DynamicScaffold(
      drawer: Container(),
      showDrawer: false,
      appbar: AppBar(
        backgroundColor: config.getPrimaryColor(),
        title: Text(
          config.getAppbarTitle().substring(
                0,
                min(config.getAppbarTitle().length, 30),
              ),
        ),
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
      showFab: false,
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
              title: Text(
                config.getAppbarTitle().substring(
                      0,
                      min(config.getAppbarTitle().length, 30),
                    ),
              ),
              centerTitle: false,
              pinned: true,
              expandedHeight: 300,
              backgroundColor: config.getPrimaryColor(),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
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
                            config.getHeaderImageUrl(),
                          )),
                    ),
                  ),
                ),
              )),
          SliverToBoxAdapter(
            child: _buildHeader(config.getScreenVal("/content/adresse/header")),
          ),
          SliverToBoxAdapter(
            child: _buildBeschreibung(
                config.getScreenVal("/content/adresse/text")),
          ),
          SliverToBoxAdapter(
            child: _buildBeschreibung(
                config.getScreenVal("/content/telmail/text")),
          ),
          SliverToBoxAdapter(
            child: _buildBeschreibung(
                config.getScreenVal("/content/adresse/anfahrt")),
          ),
          SliverToBoxAdapter(
            child: _buildHeader(
                config.getScreenVal("/content/oeffnungszeiten/header")),
          ),
          SliverToBoxAdapter(
            child: _buildBeschreibung(
                config.getScreenVal("/content/oeffnungszeiten/text1")),
          ),
          SliverToBoxAdapter(
            child: _buildBeschreibung(
                config.getScreenVal("/content/oeffnungszeiten/text2")),
          ),
          SliverToBoxAdapter(
            child: _buildBeschreibung(
                config.getScreenVal("/content/oeffnungszeiten/text3")),
          ),
          SliverToBoxAdapter(
            child: _buildHeader(
                config.getScreenVal("/content/gebaeude/header")),
          ),
          SliverToBoxAdapter(
            child: _buildBeschreibung(
                config.getScreenVal("/content/gebaeude/text1")),
          ),
          SliverToBoxAdapter(
            child: _buildBeschreibung(
                config.getScreenVal("/content/gebaeude/text2")),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String text) {
    double fontSize = 14;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.nunito(
              fontSize: fontSize, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildBeschreibung(String text) {
    double fontSize = 14;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        //width: width,
        child: Text(
          text,
          textAlign: TextAlign.justify,
          style: GoogleFonts.nunito(
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}

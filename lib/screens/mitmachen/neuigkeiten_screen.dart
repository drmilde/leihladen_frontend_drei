import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leihladen_frontend_drei/config/screens/neuigkeiten_screen_config.dart';
import 'package:leihladen_frontend_drei/messaging/answer.dart';
import 'package:leihladen_frontend_drei/messaging/api/v1/rest.dart';
import 'package:leihladen_frontend_drei/messaging/helper.dart';
import 'package:leihladen_frontend_drei/messaging/news_item.dart';
import 'package:leihladen_frontend_drei/model/data_model_controller.dart';
import 'package:leihladen_frontend_drei/screens/start_screen.dart';
import 'package:leihladen_frontend_drei/widgets/dynamic_scaffold.dart';

class NeuigkeitenScreen extends StatelessWidget {
  final DataModelController dmc = Get.find();
  Rest restApi = new Rest();

  NeuigkeitenScreenConfig config = new NeuigkeitenScreenConfig();
  String title = "Neuigkeiten";
  String beschreibung =
      "Hier finden Sie die aktuellen Neuigkeiten des Leihladens."
      " Wir informieren Sie über das aktuelle Geschehen"
      " Schauen Sie einfach immer mal wieder rein.";
  String imageUrl =
      "http://medsrv.informatik.hs-fulda.de/leihladenapp/data/config/leihladenfulda/boot/nackt.jpg";
  String inventarnummer = "";

  NeuigkeitenScreen();

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
      showFab: false,
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
        //endDrawer: AppDrawerWidget(),
        body: FutureBuilder(
      //future: loader.loadUncomproessedCatalogDataFromServer(),
      future: restApi.listAllNews(),
      // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List<Answer>> snapshot) {
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
          List<Answer> result = snapshot.data as List<Answer>;
          return _buildCustomScrollView(context, result);
        }
      },
    )
        //body: _buildCustomScrollView(context),
        );
  }

  Widget _buildCustomScrollView(BuildContext context, List<Answer> result) {
    return CustomScrollView(
      key: key,
      slivers: [
        SliverAppBar(
            centerTitle: true,
            pinned: true,
            expandedHeight: 200,
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
          child: _buildBeschreibung(beschreibung),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return _getContent(result[result.length - index - 1]);
            },
            childCount: result.length,
          ),
        ),
      ],
    );
  }

  Widget _getContent(Answer answer) {
    String content = Helper.decodeContent(answer.content);
    NewsItem ni = newsItemFromJson(content);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1),
        ),
        //color: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _cardLine(
                ni.datum,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              _cardLine(
                ni.titel,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              /*
              SizedBox(height: 8),
              _cardLine(
                ni.subtitel,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.italic,
                ),
              ),

               */
              SizedBox(height: 8),
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.black12,
              ),
              SizedBox(height: 8),
              _cardLine(
                ni.inhalt,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardLine(String content,
      {TextAlign? textAlign = TextAlign.justify, required TextStyle? style}) {
    return Container(
      width: double.infinity,
      child: Text(
        content,
        textAlign: textAlign,
        style: style,
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

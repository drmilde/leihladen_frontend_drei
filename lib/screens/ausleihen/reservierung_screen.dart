import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leihladen_frontend_drei/config/screens/reservierung_screen_config.dart';
import 'package:leihladen_frontend_drei/katalog/eintrag.dart';
import 'package:leihladen_frontend_drei/messaging/answer.dart';
import 'package:leihladen_frontend_drei/messaging/api/v1/rest.dart';
import 'package:leihladen_frontend_drei/model/data_model_controller.dart';
import 'package:leihladen_frontend_drei/widgets/dynamic_scaffold.dart';
import 'package:leihladen_frontend_drei/widgets/entry_card_widget.dart';

class ReservierungScreen extends StatefulWidget {
  ReservierungScreen();

  @override
  _ReservierungScreenState createState() => _ReservierungScreenState();
}

class _ReservierungScreenState extends State<ReservierungScreen> {
  final DataModelController dmc = Get.find();

  ReservierungScreenConfig config = new ReservierungScreenConfig();

  String title = "Reservierung";

  String beschreibung = "Die für Sie reservierte Dinge.";

  String imageUrl =
      "http://medsrv.informatik.hs-fulda.de/leihladenapp/data/config/leihladenfulda/boot/nackt.jpg";

  Rest restApi = new Rest();

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
      fab: Container(),
      showFab: false,
      body: FutureBuilder(
        future: restApi.reservierungListUdid(
            udid: dmc.store.value.leihausweis.udid),
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
                child: Center(
                  child: Text(
                    "loading data....",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ));
          } else {
            // Fall 3: Daten wurden geladen und können angezeigt werden
            List<Answer> result = snapshot.data as List<Answer>;
            return _buildContent(context, result);
          }
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<Answer> result) {
    return Scaffold(
      //endDrawer: AppDrawerWidget(),
      body: CustomScrollView(
        key: widget.key,
        slivers: [
          SliverAppBar(
              centerTitle: true,
              pinned: true,
              expandedHeight: 200,
              backgroundColor: config.getPrimaryColor(),
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      // neu laden
                    });
                  },
                  icon: Icon(Icons.refresh),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      restApi.reservierungDeleteUdid(
                          dmc.store.value.leihausweis.udid);
                    });
                  },
                  icon: Icon(Icons.clear),
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
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildWarenkorbCard(result[index]),
                );
              },
              childCount: result.length,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWarenkorbCard(Answer answer) {
    //String inventarnummer = DataModel.store.value.warenkorb.data[index];
    String inventarnummer = answer.inventarnummer;
    Eintrag entry = dmc.katalog.getEintrayByInventarnummer(inventarnummer);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            // TODO remove from reservierung
            setState(() {
              restApi.reservierungDeleteInventarnummer(entry.inventarnummer);
            });
          },
          child: EntryCardWidget(entry)),
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

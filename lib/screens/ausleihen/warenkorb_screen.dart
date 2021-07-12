import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leihladen_frontend_drei/config/screens/warenkorb_screen_config.dart';
import 'package:leihladen_frontend_drei/katalog/eintrag.dart';
import 'package:leihladen_frontend_drei/messaging/answer.dart';
import 'package:leihladen_frontend_drei/messaging/api/v1/rest.dart';
import 'package:leihladen_frontend_drei/model/data_model_controller.dart';
import 'package:leihladen_frontend_drei/screens/ausleihen/leihausweis_screen.dart';
import 'package:leihladen_frontend_drei/screens/ausleihen/reservierung_screen.dart';
import 'package:leihladen_frontend_drei/screens/ausleihen/zeitraum_auswaehlen_screen.dart';
import 'package:leihladen_frontend_drei/widgets/animated_button_widget.dart';
import 'package:leihladen_frontend_drei/widgets/dynamic_scaffold.dart';
import 'package:leihladen_frontend_drei/widgets/entry_card_widget.dart';

class WarenkorbScreen extends StatelessWidget {
  final DataModelController dmc = Get.find();
  WarenkorbScreenConfig config = new WarenkorbScreenConfig();

  String title = "Warenkorb";

  String beschreibung = "Der Warenkorb zeigt Ihre ausgewählten Dinge."
      " Mit einem Klick auf den Mülleimer entfernen Sie das Ding aus dem Warenkorb.";

  String imageUrl =
      "http://medsrv.informatik.hs-fulda.de/leihladenapp/data/config/leihladenfulda/boot/nackt.jpg";

  String inventarnummer = "";
  ZeitraumAuswaehlenScreen zaw = ZeitraumAuswaehlenScreen(DateTime.now());
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
              expandedHeight: 200,
              backgroundColor: config.getPrimaryColor(),
              actions: [
                IconButton(
                  onPressed: () {
                    dmc.warenkorbClearData();
                  },
                  icon: Icon(Icons.clear),
                ),
                IconButton(
                  onPressed: () {
                    dmc.saveStore();
                  },
                  icon: Icon(Icons.save_outlined),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
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
                            imageUrl,
                          )),
                    ),
                  ),
                ),
              )),
          SliverToBoxAdapter(
            child: _buildBeschreibung(context, beschreibung),
          ),
          Obx(
            () => SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _buildWarenkorbCard(index);
                },
                childCount: dmc.store.value.warenkorb.data.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarenkorbCard(int index) {
    //String inventarnummer = DataModel.store.value.warenkorb.data[index];
    String inventarnummer = dmc.store.value.warenkorb.data[index];
    Eintrag entry = dmc.katalog.getEintrayByInventarnummer(inventarnummer);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          // TODO delete from warenkorb
          dmc.warenkorbRemoveData(entry.inventarnummer);
        },
        child: EntryCardWidget(entry),
      ),
    );
  }

  Widget _buildBeschreibung(BuildContext context, String beschreibung) {
    double fontSize = 14;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Beschreibung",
                style: GoogleFonts.nunito(
                    fontSize: fontSize, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => zaw));
                    },
                    icon: Icon(Icons.calendar_today_outlined),
                  ),
                  AnimatedButtonWidget(
                    callback: () {
                      // Hier reservieren
                      _doReservierung(context);
                    },
                    child: Text(
                      "Reservieren",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    color: config.getPrimaryColor(),
                  ),
                ],
              ),
            ],
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

  void _doReservierung(BuildContext context) async {
    String startDate = zaw.getUSDateString(zaw.startDate);
    String endDate = zaw.getUSDateString(zaw.endDate);
    String udid = dmc.store.value.leihausweis.udid;

    // leeres Formular -> Leihausweis nicht gültig
    if (udid == "53317557") {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LeihausweisScreen()));
      return;
    }

    List<Answer> bereitsReseviert =
        await restApi.reservierungListUdid(udid: udid);

    // Reservierung durchführen
    // TODO check, ob bereits reserviert
    for (String inventarnummer in dmc.store.value.warenkorb.data) {
      bool doesContain = false;
      for (Answer a in bereitsReseviert) {
        if (a.inventarnummer == inventarnummer) {
          doesContain = true;
          break;
        }
      }
      if (!doesContain) {
        restApi.reservierungAddUdidInventarnummer(
            udid, inventarnummer, startDate, endDate);
      }
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReservierungScreen(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leihladen_frontend_drei/config/screens/app_drawer_widget_config.dart';
import 'package:leihladen_frontend_drei/model/data_model_controller.dart';
import 'package:leihladen_frontend_drei/screens/abholen/laden_info_screen.dart';
import 'package:leihladen_frontend_drei/screens/ausleihen/entliehen_screen.dart';
import 'package:leihladen_frontend_drei/screens/ausleihen/leihausweis_screen.dart';
import 'package:leihladen_frontend_drei/screens/ausleihen/reservierung_screen.dart';
import 'package:leihladen_frontend_drei/screens/ausleihen/warenkorb_screen.dart';
import 'package:leihladen_frontend_drei/screens/info/impressum_screen.dart';
import 'package:leihladen_frontend_drei/screens/info/system_information_screen.dart';
import 'package:leihladen_frontend_drei/screens/start_screen.dart';

import 'app_drawer_entry_widget.dart';

class AppDrawerWidget extends StatelessWidget {
  final DataModelController dmc = Get.find();
  AppDrawerWidgetConfig config = AppDrawerWidgetConfig();

  @override
  Widget build(BuildContext context) {
    String nachname = "Kein";
    String vorname = "Leihausweis";
    String adresse = "Leihladen Fulda";
    if (dmc.store.value.leihausweis.nachname.length > 0) {
      nachname = "${dmc.store.value.leihausweis.nachname}";
    }
    if (dmc.store.value.leihausweis.vorname.length > 0) {
      vorname = "${dmc.store.value.leihausweis.vorname}";
    }
    if (dmc.store.value.leihausweis.adresse.length > 0) {
      adresse = "${dmc.store.value.leihausweis.adresse}";
    }

    return SafeArea(
      child: Drawer(
          child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LeihausweisScreen()));
              },
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: config.getPrimaryColor(),
                ),
                accountName: Text("${nachname} ${vorname}"),
                accountEmail: Text("${adresse}"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    "${vorname[0]}${nachname[0]}",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
            ),
            /*
            AppDrawerEntryWidget("Einführung in die App",
                "assets/images/symbol/info_symbol.png", MitmachenScreen()),
             */

            AppDrawerEntryWidget(
              //"zum StartScreen",
              config.getKachelText(11),
              //"assets/images/symbol/home_symbol.png",
              config.getKachelIcon(11),
              //InfoScreen(),
              StartScreen(),
              replace: false,
              screenName: "ServerAuswahlScreen",
            ),

            AppDrawerEntryWidget(
              //"Informationen zum Bürgerzentrum",
              config.getKachelText(2),
              //"assets/images/symbol/home_symbol.png",
              config.getKachelIcon(1),
              //InfoScreen(),
              LadenInfoScreen(),
              replace: false,
            ),

            Divider(thickness: 2),
            AppDrawerEntryWidget(
              //"Ihr Leihausweis",
              //"assets/images/symbol/leihausweis_symbol.png",
              config.getKachelText(3),
              config.getKachelIcon(3),
              LeihausweisScreen(),
              replace: false,
            ),
            AppDrawerEntryWidget(
              //"Ihr Warenkorb",
              //"assets/images/symbol/warenkorb_symbol.png",
              config.getKachelText(4),
              config.getKachelIcon(4),
              //WarenkorbScreen(),
              WarenkorbScreen(),
              replace: false,
            ),
            AppDrawerEntryWidget(
              //"Ihre Reservierung",
              //"assets/images/symbol/order_symbol.png",
              config.getKachelText(5),
              config.getKachelIcon(5),
              //ReservierungScreen(),
              ReservierungScreen(),
              replace: false,
            ),
            AppDrawerEntryWidget(
              //"Von Ihnen entliehen",
              //"assets/images/symbol/entliehen_symbol.png",
              config.getKachelText(6),
              config.getKachelIcon(6),
              //EntliehenScreen(),
              EntliehenScreen(),
              replace: false,
            ),
            Divider(thickness: 2),
            //AppDrawerEntryWidget("Administrator",  "assets/images/symbol/info_symbol.png", MitmachenScreen()),
            AppDrawerEntryWidget(
              //"Systeminformation",
              //"assets/images/symbol/system_symbol.png",
              config.getKachelText(8),
              config.getKachelIcon(8),
              //SystemInformationScreen(),
              SystemInformationScreen(),
              replace: false,
            ),
            Divider(thickness: 2),
            AppDrawerEntryWidget(
              //"Impressum & Datenschutz",
              //"assets/images/symbol/info_symbol.png",
              config.getKachelText(9),
              config.getKachelIcon(9),
              //ImpressumScreen(),
              ImpressumScreen(),
              replace: false,
              showIcon: false,
            ),
          ],
        ),
      )),
    );
  }
}

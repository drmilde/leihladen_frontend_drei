import 'package:flutter/material.dart';
import 'package:leihladen_frontend_drei/config/screens/app_drawer_widget_config.dart';
import 'package:leihladen_frontend_drei/model/data_model.dart';
import 'package:leihladen_frontend_drei/screens/ausleihen/leihausweis_screen.dart';
import 'package:leihladen_frontend_drei/screens/start_screen.dart';

import 'app_drawer_entry_widget.dart';

class AppDrawerWidget extends StatelessWidget {
  AppDrawerWidgetConfig config = AppDrawerWidgetConfig();

  @override
  Widget build(BuildContext context) {
    String nachname = "Kein";
    String vorname = "Leihausweis";
    String adresse = "Leihladen Fulda";
    if (DataModel.store.leihausweis.nachname.length > 0) {
      nachname = "${DataModel.store.leihausweis.nachname}";
    }
    if (DataModel.store.leihausweis.vorname.length > 0) {
      vorname = "${DataModel.store.leihausweis.vorname}";
    }
    if (DataModel.store.leihausweis.adresse.length > 0) {
      adresse = "${DataModel.store.leihausweis.adresse}";
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
              StartScreen(),
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
              StartScreen(),
              replace: false,
            ),
            AppDrawerEntryWidget(
              //"Ihre Reservierung",
              //"assets/images/symbol/order_symbol.png",
              config.getKachelText(5),
              config.getKachelIcon(5),
              //ReservierungScreen(),
              StartScreen(),
              replace: false,
            ),
            AppDrawerEntryWidget(
              //"Von Ihnen entliehen",
              //"assets/images/symbol/entliehen_symbol.png",
              config.getKachelText(6),
              config.getKachelIcon(6),
              //EntliehenScreen(),
              StartScreen(),
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
              StartScreen(),
              replace: false,
            ),
            Divider(thickness: 2),
            AppDrawerEntryWidget(
              //"Impressum & Datenschutz",
              //"assets/images/symbol/info_symbol.png",
              config.getKachelText(9),
              config.getKachelIcon(9),
              //ImpressumScreen(),
              StartScreen(),
              replace: false,
              showIcon: false,
            ),
          ],
        ),
      )),
    );
  }
}

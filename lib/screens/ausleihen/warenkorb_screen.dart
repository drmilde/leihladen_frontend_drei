import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leihladen_frontend_drei/config/screens/warenkorb_screen_config.dart';
import 'package:leihladen_frontend_drei/katalog/eintrag.dart';
import 'package:leihladen_frontend_drei/model/data_model_controller.dart';
import 'package:leihladen_frontend_drei/screens/ausleihen/reservierung_screen.dart';
import 'package:leihladen_frontend_drei/widgets/dynamic_scaffold.dart';
import 'package:leihladen_frontend_drei/widgets/entry_card_widget.dart';

class WarenkorbScreen extends StatelessWidget {
  final DataModelController dmc = Get.find();
  WarenkorbScreenConfig config = new WarenkorbScreenConfig();

  String title = "Warenkorb";

  String beschreibung = "Der Warenkorb zeigt Ihre ausgwählten Dinge."
      " Durch Wischen können Sie das Ding entfernen.";

  String imageUrl =
      "http://medsrv.informatik.hs-fulda.de/leihladenapp/data/config/leihladenfulda/boot/nackt.jpg";

  String inventarnummer = "";

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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ReservierungScreen()));
        },
        child: Text("R", style: TextStyle(color: Colors.white)),
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
                            imageUrl,
                          )),
                    ),
                  ),
                ),
              )),
          SliverToBoxAdapter(
            child: _buildBeschreibung(beschreibung),
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
    Eintrag entry =
        dmc.katalog.getEintrayByInventarnummer(inventarnummer);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: EntryCardWidget(entry),
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

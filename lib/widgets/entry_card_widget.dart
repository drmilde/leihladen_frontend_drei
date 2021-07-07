import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leihladen_frontend_drei/config/screens/katalog_screen_config.dart';
import 'package:leihladen_frontend_drei/katalog/eintrag.dart';
import 'package:leihladen_frontend_drei/model/data_model_controller.dart';
import 'package:leihladen_frontend_drei/screens/katalog/katalog_detail_screen.dart';
import 'package:leihladen_frontend_drei/widgets/animated_button_widget.dart';
import 'package:leihladen_frontend_drei/widgets/warenkorb_row_widget.dart';

class EntryCardWidget extends StatelessWidget {
  final DataModelController dmc = Get.find();
  KatalogScreenConfig config = new KatalogScreenConfig();
  Eintrag entry;
  double height;
  bool left = true;

  EntryCardWidget(this.entry, {this.height = 340, this.left = true});

  @override
  Widget build(BuildContext context) {
    return _buildSizedCard(context, entry, height: this.height);
  }

  Widget _buildSizedCard(BuildContext context, Eintrag entry,
      {double height = 340}) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => KatalogDetailScreen(
                  entry: entry,
                )));
      },
      child: _newContent(height, entry, context, left: left),
    );
    //return _createOldContent(height, entry, context);
  }

  Widget _newContent(double height, Eintrag entry, BuildContext context,
      {bool left = true}) {
    if (left) {
      return Row(
        children: [
          _ImageContainer(entry),
          SizedBox(
            width: 8,
          ),
          _textContainer(entry),
        ],
      );
    } else {
      return Row(
        children: [
          _textContainer(entry),
          SizedBox(
            width: 8,
          ),
          _ImageContainer(entry),
        ],
      );
    }
  }

  Expanded _textContainer(Eintrag entry) {
    return Expanded(
      child: Container(
        height: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            Text(
              entry.bezeichnung,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Expanded(
              child: Container(
                child: Text(
                  entry.beschreibung,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Stack(
              children: [
                Container(
                    //color: Colors.lime,
                    height: 45,
                    width: double.infinity),
                Positioned(
                  top: 5,
                  right: 16,
                  child: AnimatedButtonWidget(
                    color: config.getPrimaryColor(),
                    width: 35,
                    text: "+",
                    callback: () {
                      dmc.warenkorbAddData(entry.inventarnummer);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _ImageContainer(Eintrag entry) {
    return Container(
      height: 160,
      width: 160,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(config.getKatalogImageUrl(entry.bilder[0])),
          fit: BoxFit.cover,
        ),
        color: Colors.black12,
        border: new Border.all(
          color: config.getPrimaryColor(),
          width: 2.0,
          style: BorderStyle.solid,
        ),
        borderRadius: new BorderRadius.only(
          bottomLeft: new Radius.circular(20.0),
          bottomRight: new Radius.circular(20.0),
          topLeft: new Radius.circular(20.0),
          topRight: new Radius.circular(20.0),
        ),
      ),
    );
  }
}

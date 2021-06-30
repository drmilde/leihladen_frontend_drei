import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leihladen_frontend_drei/config/screens/katalog_screen_config.dart';
import 'package:leihladen_frontend_drei/katalog/eintrag.dart';
import 'package:leihladen_frontend_drei/model/data_model_controller.dart';
import 'package:leihladen_frontend_drei/widgets/animated_delete_button.dart';

import 'animated_button_widget.dart';

class WarenkorbRowWidget extends StatelessWidget {
  final DataModelController dmc = Get.find();
  KatalogScreenConfig config = new KatalogScreenConfig();
  Eintrag entry;

  WarenkorbRowWidget(this.entry);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedButtonWidget(
            color: config.getPrimaryColor(),
            text: "Warenkorb+",
            callback: () {
              dmc.warenkorbAddData(entry.inventarnummer);
            },
          ),
          AnimatedDeleteButton(entry.inventarnummer),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leihladen_frontend_drei/model/data_model_controller.dart';

class AnimatedDeleteButton extends StatelessWidget {
  final DataModelController dmc = Get.find();
  String inventarnummer = "unkown";

  AnimatedDeleteButton(this.inventarnummer) {}

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedCrossFade(
        firstChild: GestureDetector(
          onTap: () {
            dmc.warenkorbRemoveData(inventarnummer);
          },
          child: _makeContent("1"),
        ),
        secondChild: _makeContent("0"),
        crossFadeState: dmc.store.value.warenkorb.containsData(inventarnummer)
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: Duration(milliseconds: 200),
      );
    });
  }

  Widget _makeContent(String text) {
    return Container(
      width: 60,
      height: 35,
      //color: Colors.green,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 20,
            color: (text != "0") ? Colors.green : Colors.white,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                color: (text != "0") ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          Icon(
            Icons.delete,
            size: 30,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leihladen_frontend_drei/model/data_model.dart';

class AnimatedDeleteButton extends StatelessWidget {
  bool _doesContain = true;
  String inventarnummer = "unkown";

  AnimatedDeleteButton(this.inventarnummer) {
    _doesContain = DataModel.store.value.warenkorb.containsData(inventarnummer);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DataModel.store.value.warenkorb.removeData(inventarnummer);
        _doesContain =
            DataModel.store.value.warenkorb.containsData(inventarnummer);
      },
      child: Obx(() {
        _doesContain =
            DataModel.store.value.warenkorb.containsData(inventarnummer);
        //return Text("xxxx : ${_doesContain}");
        return AnimatedCrossFade(
          firstChild: _makeContent("1"),
          secondChild: _makeContent("0"),
          crossFadeState: _doesContain
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: Duration(milliseconds: 200),
        );
      }),
    );
  }

  Widget _makeContent(String text) {
    return Container(
      width: 50,
      height: 35,
      //color: Colors.green,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
              color: Colors.black,
              fontSize: 16,
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

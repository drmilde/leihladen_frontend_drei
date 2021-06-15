import 'package:flutter/material.dart';

class KachelWidget extends StatelessWidget {
  Color color;
  String title;
  int index;
  String iconUrl;

  KachelWidget(this.color, this.title, this.index, this.iconUrl);

  @override
  Widget build(BuildContext context) {
    return _makeKachel(color, title, index);
  }

  Widget _makeKachel(Color color, String title, int index) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 48,
              width: 48,
              child: ImageIcon(
                NetworkImage(iconUrl),
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
                //fontFamily: Utils.ubuntuRegularFont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

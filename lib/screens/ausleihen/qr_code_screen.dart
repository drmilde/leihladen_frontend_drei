import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leihladen_frontend_drei/config/screens/leihausweis_screen_config.dart';
import 'package:leihladen_frontend_drei/widgets/dynamic_scaffold.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeScreen extends StatelessWidget {
  LeihausweisScreenConfig config = LeihausweisScreenConfig();
  String data = "kein Leihausweis";

  QrCodeScreen(this.data);

  @override
  Widget build(BuildContext context) {
    return DynamicScaffold(
      drawer: Container(),
      appbar: AppBar(
        title: Text("Leihausweis"),
      ),
      fab: Container(),
      showDrawer: false,
      showAppbar: false,
      showFab: false,
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(config.getAppbarTitle()),
          backgroundColor: config.getPrimaryColor(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Übertragene Daten im QRCode: ",
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Container(
                    width: double.infinity,
                    color: Theme.of(context).bottomAppBarColor,
                    child: Text(
                      data,
                      style: TextStyle(
                        fontFamily: "Courier",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: Container(
                      height: 300,
                      child: QrImage(
                        data: data,
                        version: QrVersions.auto,
                        //size: MediaQuery.of(context).size.width * 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

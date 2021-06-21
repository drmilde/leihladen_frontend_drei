import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leihladen_frontend_drei/config/servers/server_liste.dart';
import 'package:leihladen_frontend_drei/model/data_model.dart';
import 'package:leihladen_frontend_drei/screens/loader/data_loader_screen.dart';
import 'package:leihladen_frontend_drei/widgets/dynamic_scaffold.dart';

class ServerAuswahlScreen extends StatelessWidget {
  ServerListe serverliste = ServerListe.init();
  String bootServer = "localhost";
  String bootPort = "80";
  String bootDir = "/data/config/leihladenfulda/boot/";

  @override
  Widget build(BuildContext context) {
    return DynamicScaffold(
      drawer: Drawer(),
      appbar: AppBar(),
      showAppbar: false,
      fab: _buildListe(),
      showFab: false,
      body: FutureBuilder(
        future: DataModel.getServerliste(),
        // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<ServerListe> snapshot) {
          // Fall 1: keine Daten geladen
          if (snapshot.connectionState == ConnectionState.none &&
              snapshot.hasData == null) {
            return Container(
              color: Colors.red,
            );
          }
          // Fall 2: Daten werden noch geladen
          if (!snapshot.hasData) {
            return Container(
              color: Colors.blue,
            );
          } else {
            // Fall 3: Daten wurden geladen und können angezeigt werden
            serverliste = snapshot.data as ServerListe;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Leihladen auswählen",
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Text(
                    "Hier finden Sie die Liste der Leihläden, die"
                    " Sie aktuell mit der Leihladen-Fulda-App nutzen können."
                    " Bitte wählen Sie Ihren Favoriten aus. Viel Spass beim"
                    " Stöbern in den Katalogen.",
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Expanded(child: _buildListe()),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildListe() {
    return ListView.builder(
        itemCount: serverliste.server.length,
        itemBuilder: (context, index) {
          String fname = serverliste.server[index].logo;
          String imagUlr = "http://${bootServer}:${bootPort}${bootDir}${fname}";

          return GestureDetector(
            onTap: () {
              print(bootServer);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DataLoaderScreen()));
            },
            child: _buildCard(imagUlr, index),
          );
        });
  }

  Widget _buildCard(String imagUlr, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        //color: Colors.black12,
        decoration: new BoxDecoration(
          //color: Colors.purple,
          border: new Border.all(
            color: Colors.black12,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    border: new Border.all(
                        color: Colors.black12,
                        width: 1.0,
                        style: BorderStyle.solid),
                    image: DecorationImage(
                      image: NetworkImage(imagUlr),
                    )),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      serverliste.server[index].name,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      //height: 100,
                      child: Text(
                        serverliste.server[index].desc,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    /*
                        Text(serverliste.server[index].logo),
                        Text(serverliste.server[index].protokoll),
                        Text(serverliste.server[index].config),
                        Text(serverliste.server[index].configformat),
                        Text(serverliste.server[index].configversion),
                        Text(serverliste.server[index].catalog),
                        Text(serverliste.server[index].catalogformat),
                        Text(serverliste.server[index].catalogversion),
                        Text(serverliste.server[index].server),
                        Text(serverliste.server[index].port),
                        Text(serverliste.server[index].secured),

                         */
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

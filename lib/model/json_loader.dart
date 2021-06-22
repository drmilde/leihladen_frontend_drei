import 'dart:convert';

import 'package:http/http.dart';
import 'package:leihladen_frontend_drei/config/config.dart';
import 'package:leihladen_frontend_drei/config/servers/server_liste.dart';
import 'package:leihladen_frontend_drei/messaging/communication.dart';

import '../katalog/katalog.dart';

class JsonLoader {
  late Communication com;

  String content = '''
  {
   "stand":"21.6.2021",
   "version":"1.0",
   "description":"Liste der aktuellen Leihladenserver",
   "server":[
      {
         "name":"Der Gartenladen",
         "desc":"Der Gartenladen ist der Beispielalden. Grün und hübsch.",
         "logo":"logo_gartenladen.png",
         "protokoll":"v2",
         "config":"config.json",
         "configformat":"uncompressed",
         "configversion":"v0",
         "catalog":"katalog.json",
         "catalogformat":"uncompressed",
         "catalogversion":"v1",
         "server":"medsrv.informatik.hs-fulda.de",
         "port":"80",
         "prepath":"/gartenladen/",
         "secured":"nein"
      }
   ]
}
  ''';

  //"http://medsrv.informatik.hs-fulda.de/leihladenapp/data/config/leihladenfulda/servers.json"

  String bootServerPort = "medsrv.informatik.hs-fulda.de:80";
  String bootServerDir = "/leihladenapp/data/config/leihladenfulda/";

  String rootDir = "/data/config/leihladenfulda/";
  String katalogName = "katalog.json";
  String configName = "config.json";

  JsonLoader() {
    com = Communication();
  }

  // BOOT LOADING

  Future<ServerListe> loadUncompressedServerListe(
      {String serverListeFileName = "servers.json"}) async {
    String jsonString =
        await _fetchUncompressedServerliste(serverListeFileName);
    jsonString = jsonString.trim();

    return serverlisteFromJson(jsonString);
  }

  Future<String> _fetchUncompressedServerliste(String fileName) async {
    //return content;
    Response response = await get(
        Uri.http(bootServerPort, "${bootServerDir}${fileName}"));

    String result = utf8.decode(response.bodyBytes, allowMalformed: true);

    return result;
  }

  // CONFIG LOADING

  Future<Config> loadUncompressedConfigFromServer({
    String dataServer = "",
    String dataPort = "",
    String dataPrepath = "",
    String dataDir = "",
    String configFileName = "config.json",
  }) async {
    String jsonString = await _fetchUncompressedFromServer(
        dataServer: dataServer,
        dataPort: dataPort,
        dataPrepath: dataPrepath,
        dataDir: dataDir,
        fileName: configFileName);
    jsonString = jsonString.trim();

    return configFromJson(jsonString);
  }

  // CATALOG LOADING

  Future<Katalog> loadUncompressedCatalogDataFromServer(
      {String dataServer = "",
      String dataPort = "",
      String dataPrepath = "",
      String dataDir = "",
      String catalogFileName = "katalog.json"}) async {
    String jsonString = await _fetchUncompressedFromServer(
        dataServer: dataServer,
        dataPort: dataPort,
        dataPrepath: dataPrepath,
        dataDir: dataDir,
        fileName: catalogFileName);
    jsonString = jsonString.trim();
    return katalogFromJson(jsonString);
  }

  // HELPER LOADING

  Future<String> _fetchUncompressedFromServer({
    String dataServer = "",
    String dataPort = "",
    String dataPrepath = "",
    String dataDir = "",
    String fileName = "",
  }) async {
    print(
        "Fetching data from DataServer ${dataServer}:${dataPort}  ...  ${dataPrepath}${dataDir}${fileName}");
    /*
    Response response = await get(
        Uri.http("${com.serverName}:${com.port}", "${rootDir}${fileName}"));

     */
    Response response = await get(
        Uri.http("${dataServer}:${dataPort}", "${dataPrepath}${dataDir}${fileName}"));

    String result = utf8.decode(response.bodyBytes, allowMalformed: true);
    //print(result);
    return result;
  }

  // Helper

  String rebaseImagePath(String imageName) {
    List<String> parts = imageName.split("/");
    if (parts != null) {
      imageName = parts.last;
    }
    return imageName;
  }
}

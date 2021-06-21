import 'dart:convert';

import 'package:http/http.dart';
import 'package:leihladen_frontend_drei/config/config.dart';
import 'package:leihladen_frontend_drei/config/servers/server_liste.dart';
import 'package:leihladen_frontend_drei/messaging/communication.dart';
import '../katalog/katalog.dart';

class JsonLoader {
  late Communication com;
  String rootDir = "/data/config/leihladenfulda/";
  String katalogName = "katalog.json";
  String configName = "config.json";

  JsonLoader() {
    com = Communication();
  }

  // BOOT LOADING

  Future<ServerListe> loadUncompressedServerListe(
      {String serverListeFileName = "servers.json"}) async {
    String jsonString = await _fetchUncompressedServerliste(serverListeFileName);
    jsonString = jsonString.trim();

    return serverlisteFromJson(jsonString);
  }

  Future<String> _fetchUncompressedServerliste(String fileName) async {
    print("Lade die Serverliste");
    Response response = await get(
        Uri.http("localhost:80", "/data/config/leihladenfulda/${fileName}"));

    String result = utf8.decode(response.bodyBytes, allowMalformed: true);
    return result;
  }


  // CONFIG LOADIND

  Future<Config> loadUncompressedConfigFromServer(
      {String configFileName = "config.json"}) async {
    String jsonString = await _fetchUncompressedFromServer(configFileName);
    jsonString = jsonString.trim();

    return configFromJson(jsonString);
  }

  // CATALOG LOADING

  Future<Katalog> loadUncompressedCatalogDataFromServer(
      {String katalogFileName = "katalog.json"}) async {
    String jsonString = await _fetchUncompressedFromServer(katalogFileName);
    jsonString = jsonString.trim();
    return katalogFromJson(jsonString);
  }


  // HELPER LOADING

  Future<String> _fetchUncompressedFromServer(String fileName) async {
    print("${com.serverName}:${com.port}  ...  ${rootDir}${fileName}");
    Response response = await get(
        Uri.http("${com.serverName}:${com.port}", "${rootDir}${fileName}"));

    String result = utf8.decode(response.bodyBytes, allowMalformed: true);
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

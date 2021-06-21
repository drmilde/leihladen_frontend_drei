// To parse this JSON data, do
//
//     final serverliste = serverlisteFromJson(jsonString);

import 'dart:convert';

ServerListe serverlisteFromJson(String str) =>
    ServerListe.fromJson(json.decode(str));

String serverlisteToJson(ServerListe data) => json.encode(data.toJson());

class ServerListe {

  late String stand;
  late String version;
  late String description;
  late List<Server> server;

  ServerListe({
    this.stand = "",
    this.version = "",
    this.description = "",
    this.server = const [],
  });

  ServerListe.init() {
    this.stand = "21.6.2021";
    this.version = "1.0";
    this.description = "Standardliste der Leihladenserver";

    Server s = Server(
      name: "Leihladen Fulda",
      desc: "Der Leihladen in Fulda: Mutter",
      logo: "logo_leihladen.jpg",
      protokoll: "v0",
      config: "config.json.gz",
      configformat: "compressed",
      configversion: "v0",
      catalog: "json_daten_formatiert.json.gz",
      catalogformat: "compressed",
      catalogversion: "v0",
      server: "h2834086.stratoserver.net",
      port: "8080",
      prepath: "",
      secured: "nein",
    );

    this.server = [s];
  }



  factory ServerListe.fromJson(Map<String, dynamic> json) => ServerListe(
        stand: json["stand"],
        version: json["version"],
        description: json["description"],
        server:
            List<Server>.from(json["server"].map((x) => Server.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "stand": stand,
        "version": version,
        "description": description,
        "server": List<dynamic>.from(server.map((x) => x.toJson())),
      };
}

class Server {
  Server({
    this.name = "",
    this.desc = "",
    this.logo = "",
    this.protokoll = "",
    this.config = "",
    this.configformat = "",
    this.configversion = "",
    this.catalog = "",
    this.catalogformat = "",
    this.catalogversion = "",
    this.server = "",
    this.port = "",
    this.prepath = "",
    this.secured = "",
  });

  String name;
  String desc;
  String logo;
  String protokoll;
  String config;
  String configformat;
  String configversion;
  String catalog;
  String catalogformat;
  String catalogversion;
  String server;
  String port;
  String prepath;
  String secured;

  factory Server.fromJson(Map<String, dynamic> json) => Server(
        name: json["name"],
        desc: json["desc"],
        logo: json["logo"],
        protokoll: json["protokoll"],
        config: json["config"],
        configformat: json["configformat"],
        configversion: json["configversion"],
        catalog: json["catalog"],
        catalogformat: json["catalogformat"],
        catalogversion: json["catalogversion"],
        server: json["server"],
        port: json["port"],
        prepath: json["prepath"],
        secured: json["secured"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "desc": desc,
        "logo": logo,
        "protokoll": protokoll,
        "config": config,
        "configformat": configformat,
        "configversion": configversion,
        "catalog": catalog,
        "catalogformat": catalogformat,
        "catalogversion": catalogversion,
        "server": server,
        "port": port,
        "prepath": prepath,
        "secured": secured,
      };
}

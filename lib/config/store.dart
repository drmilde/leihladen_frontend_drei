// To parse this JSON data, do
//
//     final store = storeFromJson(jsonString);

import 'dart:convert';

import 'package:leihladen_frontend_drei/config/servers/server_liste.dart';

Store storeFromJson(String str) => Store.fromJson(json.decode(str));

String storeToJson(Store data) => json.encode(data.toJson());

Leihausweis leihausweisFromJson(String str) =>
    Leihausweis.fromJson(json.decode(str));

String leihausweisToJson(Leihausweis data) => json.encode(data.toJson());

String leihausweisToJsonObscured(Leihausweis data) =>
    json.encode(data.toJsonObscured());

Warenkorb warenkorbFromJson(String str) => Warenkorb.fromJson(json.decode(str));

String warenkorbToJson(Warenkorb data) => json.encode(data.toJson());

class Store {
  late String version;
  late String stand;
  late Warenkorb warenkorb;
  late Leihausweis leihausweis;
  late ServerListe serverliste;

  Store({
    required this.version,
    required this.stand,
    required this.warenkorb,
    required this.leihausweis,
    required this.serverliste,
  });

  Store.init() {
    this.version = "1.0";
    this.stand = "14.6.2021";
    this.leihausweis = Leihausweis(
      adresse: "",
      geburtsjahr: "",
      vorname: "",
      nachname: "",
      mobile: "",
      passwort: "",
      udid: "",
    );
    this.warenkorb = Warenkorb(
      data: [],
    );
    this.serverliste = ServerListe.init();
  }

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        version: json["version"],
        stand: json["stand"],
        warenkorb: Warenkorb.fromJson(json["warenkorb"]),
        leihausweis: Leihausweis.fromJson(json["leihausweis"]),
        serverliste: ServerListe.fromJson(json["serverliste"]),
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "stand": stand,
        "warenkorb": warenkorb.toJson(),
        "leihausweis": leihausweis.toJson(),
        "serverliste": serverliste.toJson(),
      };
}

class Leihausweis {
  Leihausweis({
    this.nachname = "",
    this.vorname = "",
    this.adresse = "",
    this.mobile = "",
    this.geburtsjahr = "",
    this.passwort = "",
    this.udid = "",
  });

  String nachname = "";
  String vorname = "";
  String adresse = "";
  String mobile = "";
  String geburtsjahr = "";
  String passwort = "";
  String udid = "";

  factory Leihausweis.fromJson(Map<String, dynamic> json) => Leihausweis(
        nachname: json["nachname"],
        vorname: json["vorname"],
        adresse: json["adresse"],
        mobile: json["mobile"],
        geburtsjahr: json["geburtsjahr"],
        passwort: json["passwort"],
        udid: json["udid"],
      );

  Map<String, dynamic> toJson() => {
        "nachname": nachname,
        "vorname": vorname,
        "adresse": adresse,
        "mobile": mobile,
        "geburtsjahr": geburtsjahr,
        "passwort": passwort,
        "udid": udid,
      };

  Map<String, dynamic> toJsonObscured() => {
        "nachname": nachname,
        "vorname": vorname,
        "adresse": adresse,
        "mobile": mobile,
        "geburtsjahr": geburtsjahr,
        "passwort": passwort.split("").map((e) => "*").join(""),
        "udid": udid,
      };
}

class Warenkorb {
  Warenkorb({
    this.data = const [],
  });

  List<String> data = const [];

  factory Warenkorb.fromJson(Map<String, dynamic> json) => Warenkorb(
        data: List<String>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x)),
      };

  void addData(String inventarnummer) {
    if (data.contains(inventarnummer)) {
      return;
    }
    data.add(inventarnummer);
  }

  void removeData(String inventarnummer) {
    data.remove(inventarnummer);
  }

  bool containsData(String inventarnummer) {
    return data.contains(inventarnummer);
  }

  void clearData() {
    data.clear();
  }
}

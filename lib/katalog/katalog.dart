import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:leihladen_frontend_drei/katalog/eintrag.dart';

import '../model/json_loader.dart';

Katalog katalogFromJson(String str) => Katalog.fromJson(json.decode(str));

String katalogToJson(Katalog data) => json.encode(data.toJson());

enum Kategorie {
  AZ, // 0 -> 0
  Haushalt, // 2 -> 1
  Freizeit, // 7 -> 2
  Kinder, // 9 -> 3
  Spiel, // 3 -> 4
  Medien, // 5 -> 5
  Garten, // 2 -> 6
  Werkzeug, // 4 -> 7screens
  Kueche, // 8 -> 8
  Musik, // 6 -> 9
  Sonstiges, // 10
  Beliebt, // 11
  Reserviert, // 12
  Ausgeliehen, // 13
  Verschwunden, // 14
  Defekt, // 15
}

class Katalog {
  Katalog({
    this.version = "",
    this.stand = "",
    this.data = const [],
  });

  String version;
  String stand;
  List<Eintrag> data;

  factory Katalog.fromJson(Map<String, dynamic> json) => Katalog(
        version: json["version"],
        stand: json["stand"],
        data: List<Eintrag>.from(json["data"].map((x) => Eintrag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "stand": stand,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };

  // Load from assets
  static Future<Katalog> loadFromAsset() async {
    String data =
        await rootBundle.loadString('assets/katalog/av_inventar.json');
    //print(data);
    return katalogFromJson(data.trim());
  }

  static Future<Katalog> loadUncompressedFromServer() async {
    JsonLoader loader = new JsonLoader();
    Katalog k = await loader.loadUncompressedCatalogDataFromServer(
        katalogFileName: "json_daten_formatiert.json");
    return k;
  }

  List<Eintrag> filterKategorie(Kategorie kat) {
    return data.where((e) => e.kategorien.contains(kat.index)).toList();
  }

  Eintrag getEintrayByInventarnummer(String inventarnummer) {
    for (Eintrag e in data) {
      if (e.inventarnummer == inventarnummer) {
        return e;
      }
    }
    return Eintrag(
        inventarnummer: inventarnummer,
        beschreibung: "Eintrag für diese Inventarnummer nicht gefunden,",
        bezeichnung: "404: Eintrag nicht gefunden.");
  }
}

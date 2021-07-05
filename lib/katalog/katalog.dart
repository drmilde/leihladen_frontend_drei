import 'dart:convert';

import 'package:leihladen_frontend_drei/katalog/eintrag.dart';

Katalog katalogFromJson(String str) => Katalog.fromJson(json.decode(str));

String katalogToJson(Katalog data) => json.encode(data.toJson());

/*
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

 */

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

  // Helper

  void sortAscending() {
    data.sort((a, b) =>
        a.bezeichnung.toLowerCase().compareTo(b.bezeichnung.toLowerCase()));
  }

  void sortDescending() {
    data.sort((a, b) =>
        b.bezeichnung.toLowerCase().compareTo(a.bezeichnung.toLowerCase()));
  }

  void sortInventarnummer() {
    data.sort((a, b) => a.inventarnummer.compareTo(b.inventarnummer));
  }

  List<Eintrag> filterKategorie(int index) {
    return data.where((e) {
      return e.kategorien.contains(index);
    }).toList();
  }

  List<Eintrag> search(String term) {
    return data.where((e) {
      String all =
          (e.bezeichnung + e.inventarnummer + e.beschreibung).toLowerCase();
      return all.contains(term);
    }).toList();
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
      bezeichnung: "404: Eintrag nicht gefunden.",
      bilder: [
        ""
      ],
    );
  }
}

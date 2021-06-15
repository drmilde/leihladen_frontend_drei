class Eintrag {
  Eintrag({
    this.inventarnummer = "",
    this.bezeichnung = "",
    this.bilder = const [],
    this.beschreibung = "",
    this.dimension = "",
    this.enthaelt = const [],
    this.gewicht = "",
    this.kleinteil = "",
    this.kaution = "",
    this.kosten = "",
    this.kategorien = const [],
    this.raum = "",
    this.seriennummer = "",
    this.hersteller = "",
    this.typ = "",
    this.lieferantenname = "",
    this.aktivdatum = "",
    this.anschWert = "",
  });

  String inventarnummer;
  String bezeichnung;
  List<String> bilder;
  String beschreibung;
  String dimension;
  List<String> enthaelt;
  String gewicht;
  String kleinteil;
  String kaution;
  String kosten;
  List<int> kategorien;
  String raum;
  String seriennummer;
  String hersteller;
  String typ;
  String lieferantenname;
  String aktivdatum;
  String anschWert;

  factory Eintrag.fromJson(Map<String, dynamic> json) => Eintrag(
        inventarnummer: json["inventarnummer"],
        bezeichnung: json["bezeichnung"],
        bilder: List<String>.from(json["bilder"].map((x) => x)),
        beschreibung: json["beschreibung"],
        dimension: json["dimension"],
        enthaelt: List<String>.from(json["enthaelt"].map((x) => x)),
        gewicht: json["gewicht"],
        kleinteil: json["kleinteil"],
        kaution: json["kaution"],
        kosten: json["kosten"],
        kategorien: List<int>.from(json["kategorien"].map((x) => x)),
        raum: json["raum"],
        seriennummer: json["seriennummer"],
        hersteller: json["hersteller"],
        typ: json["typ"],
        lieferantenname: json["lieferantenname"],
        aktivdatum: json["aktivdatum"],
        anschWert: json["anschwert"],
      );

  Map<String, dynamic> toJson() => {
        "inventarnummer": inventarnummer,
        "bezeichnung": bezeichnung,
        "bilder": List<dynamic>.from(bilder.map((x) => x)),
        "beschreibung": beschreibung,
        "dimension": dimension,
        "enthaelt": List<dynamic>.from(enthaelt.map((x) => x)),
        "gewicht": gewicht,
        "kleinteil": kleinteil,
        "kaution": kaution,
        "kosten": kosten,
        "kategorien": List<dynamic>.from(kategorien.map((x) => x)),
        "raum": raum,
        "seriennummer": seriennummer,
        "hersteller": hersteller,
        "typ": typ,
        "lieferantenname": lieferantenname,
        "aktivdatum": aktivdatum,
        "anschwert": anschWert,
      };
}

class Eintrag {
  Eintrag({
    this.inventarnummer = "",
    this.bezeichnung = "",
    this.bilder = const [],
    this.beschreibung = "",
    this.dimension = "",
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
        gewicht: json["gewicht"],
        kleinteil: json["kleinteil"],
        kaution: json["kaution"],
        kosten: json["kosten"],
        kategorien: List<int>.from(json["kategorien"].map((x) => x)),
        raum: json["Raum"],
        seriennummer: json["Seriennummer"],
        hersteller: json["Hersteller"],
        typ: json["Typ"],
        lieferantenname: json["Lieferantenname"],
        aktivdatum: json["Aktivdatum"],
        anschWert: json["AnschWert"],
      );

  Map<String, dynamic> toJson() => {
        "inventarnummer": inventarnummer,
        "bezeichnung": bezeichnung,
        "bilder": List<dynamic>.from(bilder.map((x) => x)),
        "beschreibung": beschreibung,
        "dimension": dimension,
        "gewicht": gewicht,
        "kleinteil": kleinteil,
        "kaution": kaution,
        "kosten": kosten,
        "kategorien": List<dynamic>.from(kategorien.map((x) => x)),
        "Raum": raum,
        "Seriennummer": seriennummer,
        "Hersteller": hersteller,
        "Typ": typ,
        "Lieferantenname": lieferantenname,
        "Aktivdatum": aktivdatum,
        "AnschWert": anschWert,
      };
}

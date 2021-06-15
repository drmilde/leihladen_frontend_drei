class BasicConfig {
  BasicConfig({
    this.name = "",
    this.beschreibung = "",
    this.adresse = "",
    this.email = "",
    this.telefon = "",
    this.web = "",
  });

  String name;
  String beschreibung;
  String adresse;
  String email;
  String telefon;
  String web;

  factory BasicConfig.fromJson(Map<String, dynamic> json) => BasicConfig(
        name: json["Name"],
        beschreibung: json["Beschreibung"],
        adresse: json["Adresse"],
        email: json["Email"],
        telefon: json["Telefon"],
        web: json["Web"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Beschreibung": beschreibung,
        "Adresse": adresse,
        "Email": email,
        "Telefon": telefon,
        "Web": web,
      };
}

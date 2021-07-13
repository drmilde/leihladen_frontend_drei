// To parse this JSON data, do
//
//     final newsItem = newsItemFromJson(jsonString);

import 'dart:convert';

NewsItem newsItemFromJson(String str) => NewsItem.fromJson(json.decode(str));

String newsItemToJson(NewsItem data) => json.encode(data.toJson());

class NewsItem {
  NewsItem({
    this.datum = "",
    this.titel = "",
    this.subtitel = "",
    this.inhalt = "",
  });

  String datum;
  String titel;
  String subtitel;
  String inhalt;

  factory NewsItem.fromJson(Map<String, dynamic> json) => NewsItem(
        datum: json["datum"],
        titel: json["titel"],
        subtitel: json["subtitel"],
        inhalt: json["inhalt"],
      );

  Map<String, dynamic> toJson() => {
        "datum": datum,
        "titel": titel,
        "subtitel": subtitel,
        "inhalt": inhalt,
      };
}

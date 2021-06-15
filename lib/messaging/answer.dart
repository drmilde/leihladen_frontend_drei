// To parse this JSON data, do
//
//     final answer = answerFromJson(jsonString);

import 'dart:convert';

List<Answer> answerFromJson(String str) =>
    List<Answer>.from(json.decode(str).map((x) => Answer.fromJson(x)));

String answerToJson(List<Answer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Answer {
  Answer({
    required this.id,
    required this.inventarnummer,
    required this.status,
    required this.ext,
    required this.start,
    required this.ende,
    required this.content,
    required this.udid,
  });

  int id;
  String inventarnummer;
  String status;
  String ext;
  DateTime start;
  DateTime ende;
  String content;
  String udid;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        id: json["id"],
        inventarnummer: json["in"],
        status: json["status"],
        ext: json["ext"],
        start: DateTime.parse(json["start"]),
        ende: DateTime.parse(json["ende"]),
        content: json["content"],
        udid: json["udid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "in": inventarnummer,
        "status": status,
        "ext": ext,
        "start":
            "${start.year.toString().padLeft(4, '0')}-${start.month.toString().padLeft(2, '0')}-${start.day.toString().padLeft(2, '0')}",
        "ende":
            "${ende.year.toString().padLeft(4, '0')}-${ende.month.toString().padLeft(2, '0')}-${ende.day.toString().padLeft(2, '0')}",
        "content": content,
        "udid": udid,
      };
}

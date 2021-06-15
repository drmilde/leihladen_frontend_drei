// To parse this JSON data, do
//
//     final config = configFromJson(jsonString);

import 'dart:convert';



import 'package:leihladen_frontend_drei/config/screen_config.dart';

import 'basic_config.dart';
import 'color_config.dart';
import 'netzwerk_config.dart';

Config configFromJson(String str) => Config.fromJson(json.decode(str));

String configToJson(Config data) => json.encode(data.toJson());

class Config {
  BasicConfig basicConfig;
  NetzwerkConfig netzwerkConfig;
  ColorConfig colorConfig;
  ScreenConfig screenConfig;

  Config({
    required this.basicConfig,
    required this.netzwerkConfig,
    required this.colorConfig,
    required this.screenConfig,
  });

  factory Config.fromJson(Map<String, dynamic> json) => Config(
        basicConfig: BasicConfig.fromJson(json["BasicConfig"]),
        netzwerkConfig: NetzwerkConfig.fromJson(json["NetzwerkConfig"]),
        colorConfig: ColorConfig.fromJson(json["ColorConfig"]),
        screenConfig: ScreenConfig.fromJson(json["ScreenConfig"]),
      );

  Map<String, dynamic> toJson() => {
        "BasicConfig": basicConfig.toJson(),
        "NetzwerkConfig": netzwerkConfig.toJson(),
        "ColorConfig": colorConfig.toJson(),
        "ScreenConfig": screenConfig.toJson(),
      };
}

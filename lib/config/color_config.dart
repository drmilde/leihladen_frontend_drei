import 'dart:convert';
import 'package:flutter/material.dart';

ColorConfig colorConfigFromJson(String str) =>
    ColorConfig.fromJson(json.decode(str));

String colorConfigToJson(ColorConfig data) => json.encode(data.toJson());

class ColorConfig {
  String PrimaryColor = "#FF35ac57";
  String PrimaryColorDark = "#FF23733a";
  String AccentColor = "#FF82fcd7";
  String ScaffoldBackgroundColor = "#FFFFFFFF";
  String BottomAppBarColor = "#FFEEEEEE";
  String IconColor = "#FFFFFFFF";

  ColorConfig(
      {required this.PrimaryColor,
      required this.PrimaryColorDark,
      required this.AccentColor,
      required this.ScaffoldBackgroundColor,
      required this.BottomAppBarColor,
      required this.IconColor});

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  // json

  ColorConfig.fromJson(Map<String, dynamic> json)
      : PrimaryColor = json['PrimaryColor'],
        PrimaryColorDark = json['PrimaryColorDark'],
        AccentColor = json['AccentColor'],
        ScaffoldBackgroundColor = json['ScaffoldBackgroundColor'],
        BottomAppBarColor = json['BottomAppBarColor'],
        IconColor = json['IconColor'];

  Map<String, dynamic> toJson() => {
        'PrimaryColor': PrimaryColor,
        'PrimaryColorDark': PrimaryColorDark,
        'AccentColor': AccentColor,
        'ScaffoldBackgroundColor': ScaffoldBackgroundColor,
        'BottomAppBarColor': BottomAppBarColor,
        'IconColor': IconColor,
      };
}

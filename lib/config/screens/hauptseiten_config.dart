import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leihladen_frontend_drei/config/color_config.dart';
import 'package:leihladen_frontend_drei/model/data_model_controller.dart';

class HauptseitenConfig {
  final DataModelController dmc = Get.find();

  String seitenName = "HomeScreen";
  String galleryDir = "bilder/gallery/";
  String iconsDir = "bilder/icons/";
  String imageDir = "images/";
  String headerDir = "bilder/header/";
  String startDir = "bilder/start/";
  String basicUrl = "";

  HauptseitenConfig() {
    galleryDir = dmc.config.netzwerkConfig.galleryDir;
    iconsDir = dmc.config.netzwerkConfig.iconsDir;
    imageDir = dmc.config.netzwerkConfig.imageDir;
    headerDir = dmc.config.netzwerkConfig.headerDir;
    startDir = dmc.config.netzwerkConfig.startDir;
    basicUrl = dmc.config.netzwerkConfig.getBasicUrl();
  }

  String getKatalogImageUrl(String name) {
    return "${basicUrl}${imageDir}${name}";
  }

  String getTeamImageUrl() {
    String value = getScreenVal("/content/image/team");
    return "${basicUrl}${galleryDir}${value}";
  }

  Color getPrimaryColor() {
    return ColorConfig.fromHex(dmc.config.colorConfig.PrimaryColor);
  }

  Color getPrimaryColorDark() {
    return ColorConfig.fromHex(dmc.config.colorConfig.PrimaryColorDark);
  }

  String getHeaderImageUrl() {
    String value = getScreenVal("/content/image/header");

    return "${basicUrl}${headerDir}${value}";
  }

  String getKachelText(int index) {
    return getScreenVal("/content/kachel${index}/text");
  }

  String getKachelIcon(int index) {
    String value = getScreenVal("/content/kachel${index}/icon");
    return "${basicUrl}${iconsDir}${value}";
  }

  String getBeschreibungText() {
    return getScreenVal("/content/text/beschreibung");
  }

  String getAppbarTitle() {
    return getScreenVal("/appbar/title");
  }

  // helper
  String getScreenVal(String key) {
    return dmc.config.screenConfig.getScreen(seitenName).getVal(key);
  }
}

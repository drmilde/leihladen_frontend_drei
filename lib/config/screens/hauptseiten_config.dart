import 'package:flutter/material.dart';
import 'package:leihladen_frontend_drei/config/color_config.dart';
import 'package:leihladen_frontend_drei/model/data_model.dart';

class HauptseitenConfig {
  String seitenName = "HomeScreen";
  String galleryDir = DataModel.config.netzwerkConfig.galleryDir;
  String iconsDir = DataModel.config.netzwerkConfig.iconsDir;
  String headerDir = DataModel.config.netzwerkConfig.headerDir;
  String basicUrl = DataModel.config.netzwerkConfig.getBasicUrl();

  String getTeamImageUrl() {
    String value = getScreenVal("/content/image/team");

    return "${basicUrl}${galleryDir}${value}";
  }

  Color getPrimaryColor() {
    return ColorConfig.fromHex(DataModel.config.colorConfig.PrimaryColor);
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
    return DataModel.config.screenConfig.getScreen(seitenName).getVal(key);
  }
}

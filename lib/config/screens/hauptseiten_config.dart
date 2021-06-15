

import 'package:leihladen_frontend_drei/model/data_model.dart';

class HauptseitenConfig {
  String seitenName = "HomeScreen";
  String galleryDir = DataModel.config.netzwerkConfig.galleryDir;
  String headerDir = DataModel.config.netzwerkConfig.headerDir;
  String basicUrl = DataModel.config.netzwerkConfig.getBasicUrl();

  String getTeamImageUrl() {
    String value = _getScreenVal("/content/image/team");

    return "${basicUrl}${galleryDir}${value}";
  }

  String getHeaderImageUrl() {
    String value = _getScreenVal("/content/image/header");

    return "${basicUrl}${headerDir}${value}";
  }

  String getAppbarTitle() {
    return _getScreenVal("/appbar/title");
  }

  // helper
  String _getScreenVal(String key) {
    return DataModel.config.screenConfig.getScreen(seitenName).getVal(key);
  }
}

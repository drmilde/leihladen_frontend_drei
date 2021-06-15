import 'package:leihladen_frontend_drei/config/screens/hauptseiten_config.dart';

class AbholenScreenConfig extends HauptseitenConfig {
  AbholenScreenConfig() {
    seitenName = "AbholenScreen";
  }

  String getMapImageUrl() {
    String value = getScreenVal("/content/image/map");
    return "${basicUrl}${galleryDir}${value}";
  }
}

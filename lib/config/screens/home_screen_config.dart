import 'package:leihladen_frontend_drei/config/screens/hauptseiten_config.dart';

class HomeScreenConfig extends HauptseitenConfig {
  HomeScreenConfig() {
    seitenName = "HomeScreen";
  }


  String getText(int index) {
    return getScreenVal("/content/text/${index}");
  }

  String getLagerImageUrl() {
    String value = getScreenVal("/content/image/lager");
    return "${basicUrl}${galleryDir}${value}";
  }

}

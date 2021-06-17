import 'package:leihladen_frontend_drei/config/screens/hauptseiten_config.dart';

class AuswaehlenScreenConfig extends HauptseitenConfig {
  AuswaehlenScreenConfig() {
    seitenName = "AuswaehlenScreen";
  }

  String getKachelText(int index) {
    return getScreenVal("/content/kachel${index}/text");
  }

  int getKachelKategorie(int index) {
    int val = 0;
    try {
      val = int.parse(getScreenVal("/content/kachel${index}/kategorie"));
    } catch (e) {
      return 0;
    }
    return val;
  }

  String getKachelIcon(int index) {
    String value = getScreenVal("/content/kachel${index}/icon");
    return "${basicUrl}${iconsDir}${value}";
  }
}

import 'package:leihladen_frontend_drei/config/screens/hauptseiten_config.dart';

class StartScreenConfig extends HauptseitenConfig {
  StartScreenConfig() {
    seitenName = "StartScreen";
  }

  String getStartImageUrl(int index) {
    String value = getScreenVal("/content/image/logo${index}");
    return "${basicUrl}${startDir}${value}";
  }

  String getSupportImageUrl(int index) {
    String value = getScreenVal("/content/image/support${index}");
    return "${basicUrl}${startDir}${value}";
  }

  String getStartText() {
    String value = getScreenVal("/content/text/start");
    return "${value}";
  }
}

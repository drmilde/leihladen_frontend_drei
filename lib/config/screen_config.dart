import 'config_element.dart';

class ScreenConfig {
  List<Screen> screens;

  ScreenConfig({
    this.screens = const [],
  });

  factory ScreenConfig.fromJson(Map<String, dynamic> json) => ScreenConfig(
        screens:
            List<Screen>.from(json["Screens"].map((x) => Screen.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Screens": List<dynamic>.from(screens.map((x) => x.toJson())),
      };

  // helper
  Screen getScreen(String id) {
    for (Screen s in screens) {
      if (s.id == id) {
        return s;
      }
    }
    // keinen gefunden
    return Screen();
  }
}

class Screen {
  String id;
  List<ConfigElement> config;

  Screen({
    this.id = "",
    this.config = const [],
  });

  factory Screen.fromJson(Map<String, dynamic> json) => Screen(
        id: json["Id"],
        config: List<ConfigElement>.from(
            json["Config"].map((x) => ConfigElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Config": List<dynamic>.from(config.map((x) => x.toJson())),
      };

  String getVal(String key) {
    for (ConfigElement ce in config) {
      if (ce.key == key) {
        return ce.val;
      }
    }
    // nicht gefunden
    return "";
  }
}

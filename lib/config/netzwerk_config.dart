import 'package:leihladen_frontend_drei/model/data_model.dart';

class NetzwerkConfig {
  NetzwerkConfig({
    this.server = "",
    this.port = "",
    this.rootDir = "",
    this.galleryDir = "",
    this.headerDir = "",
    this.helpDir = "",
    this.iconsDir = "",
    this.startDir = "",
    this.htmlDir = "",
    this.imageDir = "",
    this.tempImageDir = "",
    this.protokol = "",
  });

  String server;
  String port;
  String rootDir;
  String galleryDir;
  String headerDir;
  String helpDir;
  String iconsDir;
  String startDir;
  String htmlDir;
  String imageDir;
  String tempImageDir;
  String protokol;

  factory NetzwerkConfig.fromJson(Map<String, dynamic> json) => NetzwerkConfig(
    server: json["Server"],
    port: json["Port"],
    rootDir: json["RootDir"],
    galleryDir: json["GalleryDir"],
    headerDir: json["HeaderDir"],
    helpDir: json["HelpDir"],
    iconsDir: json["IconsDir"],
    startDir: json["StartDir"],
    htmlDir: json["HtmlDir"],
    imageDir: json["ImageDir"],
    tempImageDir: json["TempImageDir"],
    protokol: json["Protokol"],
  );

  Map<String, dynamic> toJson() => {
    "Server": server,
    "Port": port,
    "RootDir": rootDir,
    "GalleryDir": galleryDir,
    "HeaderDir": headerDir,
    "HelpDir": helpDir,
    "IconsDir": iconsDir,
    "StartDir": startDir,
    "HtmlDir": htmlDir,
    "ImageDir": imageDir,
    "TempImageDir": tempImageDir,
    "Protokol": protokol,
  };


  // Helper
  String getBasicUrl() {
    return "http://${server}:${port}${DataModel.prePath}${rootDir}";
  }
}

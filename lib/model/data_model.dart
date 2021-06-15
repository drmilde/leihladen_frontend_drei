

import 'package:leihladen_frontend_drei/config/config.dart';
import 'package:leihladen_frontend_drei/config/persistence.dart';
import 'package:leihladen_frontend_drei/config/store.dart';

class DataModel {
  static late Store store;  // wird im Konstruktor initialisiert
  static late Config config;

  DataModel() {
    store = Store.init();
  }

  static setConfig(Config c) {
    config = c;
  }

  static void loadStore() {
    Persistence.load().then((String result){
      store = storeFromJson(result);
    });
  }

  static void saveStore() {
    Persistence.store(storeToJson(store));
  }
}

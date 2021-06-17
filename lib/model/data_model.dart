

import 'package:leihladen_frontend_drei/config/config.dart';
import 'package:leihladen_frontend_drei/config/persistence.dart';
import 'package:leihladen_frontend_drei/config/store.dart';
import 'package:leihladen_frontend_drei/katalog/katalog.dart';

import 'json_loader.dart';

class DataModel {
  static late Store store;  // wird im Konstruktor initialisiert
  static late Config config;
  static late Katalog katalog;
  static JsonLoader loader = new JsonLoader();
  static int katalogZugriffCount = 0;

  DataModel() {
    store = Store.init();
  }

  static setConfig(Config c) {
    config = c;
  }

  static Future<Katalog> getKatalog({bool forceLoad = false}) async {
    if (forceLoad) {
      katalog = await loader.loadUncompressedCatalogDataFromServer();
      return katalog;
    }

    // Andernfalls ... lade nach jedem 20. Zugriff neu
    katalogZugriffCount = (katalogZugriffCount + 1) % 20;
    if (katalogZugriffCount == 0) {
      print("Katalog neu geladen");
      katalog = await loader.loadUncompressedCatalogDataFromServer();
    }
    return katalog;
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

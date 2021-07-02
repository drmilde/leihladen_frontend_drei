import 'package:get/get.dart';
import 'package:leihladen_frontend_drei/config/config.dart';
import 'package:leihladen_frontend_drei/config/persistence.dart';
import 'package:leihladen_frontend_drei/config/servers/server_liste.dart';
import 'package:leihladen_frontend_drei/config/store.dart';
import 'package:leihladen_frontend_drei/katalog/katalog.dart';

import 'json_loader.dart';

class DataModelController extends GetxController {
  var store = Store.init().obs;

  late ServerListe serverliste;
  late Config config;
  late Katalog katalog;
  int katalogZugriffCount = 0;
  int serverListeZugriffCount = 0;
  String prePath = "";

  DataModelController() {
    serverliste = ServerListe.init();
  }

  setConfig(Config c) {
    config = c;
  }

  // (Update-)Funktionen Store

  void warenkorbAddData(String inventarnummer) {
    store.update((s) {
      s!.warenkorb.addData(inventarnummer);
    });
  }

  void warenkorbRemoveData(String inventarnummer) {
    store.update((s) {
      s!.warenkorb.removeData(inventarnummer);
    });
  }

  void warenkorbClearData() {
    store.update((s) {
      s!.warenkorb.clearData();
    });
  }

  bool warenkorbDoesContain(String inventarnummer) {
    bool result = false;
    store.update((s) {
      result = s!.warenkorb.containsData(inventarnummer);
    });
    return result;
  }

  // Funktion Serverliste

  Future<ServerListe> getServerliste({bool forceLoad = false}) async {
    final JsonLoader loader = new JsonLoader();

    if (forceLoad) {
      serverliste = await loader.loadUncompressedServerListe();
      return serverliste;
    }

    // Andernfalls ... lade nach jedem 20. Zugriff neu
    serverListeZugriffCount = (serverListeZugriffCount + 1) % 5;
    if (serverListeZugriffCount == 0) {
      print("Serverliste neu geladen");
      serverliste = await loader.loadUncompressedServerListe();
    }
    return serverliste;
  }

  Future<Katalog> getKatalog({bool forceLoad = false}) async {
    final JsonLoader loader = new JsonLoader();

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

  void loadStore() {
    // TODO eigentlich eine update Methode?
    Persistence.load().then((String result) {
      store.value = storeFromJson(result);
    });
  }

  void saveStore() {
    Persistence.store(storeToJson(store.value));
  }
}

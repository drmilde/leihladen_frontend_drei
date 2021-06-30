import 'package:get/get.dart';
import 'package:leihladen_frontend_drei/config/persistence.dart';
import 'package:leihladen_frontend_drei/config/store.dart';

class DataModelController extends GetxController {
  var store = Store.init().obs;

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

  bool warenkorbDoesContain(String inventarnummer) {
    bool result = false;
    store.update((s) {
      result = s!.warenkorb.containsData(inventarnummer);
    });
    return result;
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

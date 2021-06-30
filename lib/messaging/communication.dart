import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:leihladen_frontend_drei/model/data_model_controller.dart';

class Communication {
  final DataModelController dmc = Get.find();

  // http://medsrv.informatik.hs-fulda.de:12345/data/config/leihladenfulda/
  // http://localhost:80/data/config/leihladenfulda/config.json

  String get hostname {
    return "${protocol}://${serverPort}";
  }

  String get protocol {
    return "http";
  }

  String get prePath {
    return dmc.prePath;
  }

  String get serverPort {
    return "${serverName}:${port}";
  }

  String get serverName {
    //return 'medsrv.informatik.hs-fulda.de';
    //return "h2834086.stratoserver.net";
    //return '10.0.2.2';
    return 'localhost';
  }

  int get port {
    return 80;
    //return 12345;
    //return 8080;
  }

  Future<String> makeGetRequest(String url, String path) async {
    // make GET request
    print ("$url $prePath $path");
    var uri = Uri.http(url, prePath + path);
    http.Response response = await http.get(uri);

    // int statusCode = response.statusCode;
    // Map<String, String> headers = response.headers;
    // String contentType = headers['content-type'];
    String json = response.body;

    return (json);
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:leihladen_frontend_drei/messaging/answer.dart';
import 'package:leihladen_frontend_drei/messaging/communication.dart';

// REST API V1

class Rest {
  Communication com = new Communication();

  Rest() {
    com = new Communication();
  }

  // Wuensche API

  Future<String> listAllWunschliste() async {
    String result =
        await com.makeGetRequest(com.hostname, "/rest/wunschliste/list/all");
    return result;
  }

  Future<String> listAcceptedWunschliste() async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/wunschliste/list/accepted");
    return result;
  }

  Future<String> listRequestedWunschliste() async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/wunschliste/list/requested");
    return result;
  }

  Future<String> listWunschlisteByUdid(String udid) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/wunschliste/list/udid/${udid}");
    return result;
  }

  Future<String> acceptWunschliste(String id) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/wunschliste/accept/${id}");
    return result;
  }

  Future<String> deleteWunschliste(String id) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/wunschliste/delete/${id}");
    return result;
  }

  Future<String> addWunschliste(
      String udid, String start, String content) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/wunschliste/add/${udid}/${start}/${content}");
    return result;
  }

// REST Message Interface

// /rest/message/list/all -> listet alle Nachrichten auf
// /rest/message/list/last/:number -> listet die letzten :number Nachrichten auf
// /rest/message/list/distinct/udid -> liste der udids mit neuen Nachrichten
// /rest/message/delete/:id -> löscht die Nachricht mit der ID id
// /rest/message/delete/last/:number -> löscht die letzten :number Nachrichten
// /rest/message/add/:udid/:status/:content -> fügt neue Nachricht hinzu

  Future<String> listAllMessages() async {
    String result =
        await com.makeGetRequest(com.hostname, "/rest/message/list/all");
    return result;
  }

  Future<String> listMessageDistinctUdid() async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/message/list/distinct/udid");
    return result;
  }

  Future<String> listLastNMessages(int number) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/message/list/last/${number}");
    return result;
  }

  Future<String> listLastNMessagesByUdid(String udid, int number) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/message/list/last/udid/${udid}/${number}");
    return result;
  }

  Future<String> deleteMessageById(int id) async {
    String result =
        await com.makeGetRequest(com.hostname, "/rest/message/delete/${id}");
    return result;
  }

  Future<String> deleteLastNMessages(int number) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/message/delete/last/${number}");
    return result;
  }

  // r.Get("/rest/message/mark/old/:udid", http.HandlerFunc(markMessagesOldByUdid))
  Future<String> markMessagesOldByUdid(String udid) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/message/mark/old/${udid}");
    return result;
  }

  Future<String> addMessage(String udid, String status, String content) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/message/add/${udid}/${status}/${content}");
    return result;
  }

  // NEWS API
  // r.Get("/rest/news/list/all", http.HandlerFunc(getAllNews))
  Future<String> listAllNews() async {
    String result =
        await com.makeGetRequest(com.hostname, "/rest/news/list/all");
    return result;
  }

  Future<String> addNews(String udid, String content) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/news/add/${udid}/${content}");
    return result;
  }

  Future<String> deleteNewsById(int id) async {
    String result =
        await com.makeGetRequest(com.hostname, "/rest/news/delete/${id}");
    return result;
  }

  // NEWTHING API
  // r.Get("/rest/news/list/all", http.HandlerFunc(getAllNews))
  Future<String> listAllNewThings() async {
    String result =
        await com.makeGetRequest(com.hostname, "/rest/newthing/list/all");
    return result;
  }

  Future<String> addNewThing(String udid, String content) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/newthing/add/${udid}/${content}");
    return result;
  }

  Future<String> deleteNewThingById(int id) async {
    String result =
        await com.makeGetRequest(com.hostname, "/rest/newthing/delete/${id}");
    return result;
  }

  // WISH API
  // r.Get("/rest/wunsch/list/all", http.HandlerFunc(getAllWunsch))
  Future<String> listAllWunsch() async {
    String result =
        await com.makeGetRequest(com.hostname, "/rest/wunsch/list/all");
    return result;
  }

  Future<String> addWunsch(String udid, String content) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/wunsch/add/${udid}/${content}");
    return result;
  }

  Future<String> deleteWunschById(int id) async {
    String result =
        await com.makeGetRequest(com.hostname, "/rest/wunsch/delete/${id}");
    return result;
  }

  // ADMIN API

  //r.Get("/rest/admin/list", http.HandlerFunc(getAllLeihladen))

  Future<String> adminList() async {
    String result = await com.makeGetRequest(com.hostname, "/rest/admin/list");
    return result;
  }

  //r.Get("/rest/admin/list/all", http.HandlerFunc(getAllLeihladen))
  Future<String> adminListAll() async {
    String result =
        await com.makeGetRequest(com.hostname, "/rest/admin/list/all");
    return result;
  }

  //r.Get("/rest/admin/list/distinct/udid", http.HandlerFunc(getLeihladenDistinctUdid))
  Future<String> adminListDistinctUdid() async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/admin/list/distinct/udid");
    return result;
  }

  //r.Get("/rest/admin/reset", http.HandlerFunc(resetLeihladen))
  Future<String> adminReset() async {
    String result = await com.makeGetRequest(com.hostname, "/rest/admin/reset");
    return result;
  }

  //r.Get("/rest/admin/list/udid/:udid", http.HandlerFunc(getLeihladenByUdid))

  Future<String> adminListUdid(String udid) async {
    String result =
        await com.makeGetRequest(com.hostname, "/rest/admin/list/udid/${udid}");
    return result;
  }

  //r.Get("/rest/admin/list/status/:status", http.HandlerFunc(getLeihladenByStatus))

  Future<String> adminListStatus(String status) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/admin/list/status/${status}");
    return result;
  }

//r.Get("/rest/admin/delete/id/:id", http.HandlerFunc(deleteLeihladenById))

  Future<String> adminDeleteId(String id) async {
    String result =
        await com.makeGetRequest(com.hostname, "/rest/admin/delete/id/${id}");
    return result;
  }

//r.Get("/rest/admin/add/status/:udid/:status", http.HandlerFunc(addLeihladenByStatus))

  Future<String> adminAddStatus(String udid, String status) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/admin/add/status/${udid}/${status}");
    return result;
  }

//r.Get("/rest/admin/update/:id/:inventarnummer/:status/:ext/:start/:ende/:udid", http.HandlerFunc(updateDBEntry))

  Future<String> adminUpdate(String id, String inventarnummer, String status,
      String ext, String start, String ende, String udid) async {
    String result = await com.makeGetRequest(com.hostname,
        "/rest/admin/update/${id}/${inventarnummer}/${status}/${ext}/${start}/${ende}/${udid}");
    return result;
  }

//r.Get("/rest/admin/setStatus/reserviert/:id", http.HandlerFunc(setStatusReserviertByID))

  Future<String> adminReserviertId(String id) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/admin/setStatus/reserviert/${id}");
    return result;
  }

//r.Get("/rest/admin/setStatus/verliehen/:id", http.HandlerFunc(setStatusVerliehenByID))

  Future<String> adminVerliehenId(String id) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/admin/setStatus/verliehen/${id}");
    return result;
  }

//r.Get("/rest/admin/setStatus/defekt/:id", http.HandlerFunc(setStatusDefektByID))

  Future<String> adminDefektId(String id) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/admin/setStatus/defekt/${id}");
    return result;
  }

//r.Get("/rest/admin/setStatus/verloren/:id", http.HandlerFunc(setStatusVerlorenByID))

  Future<String> adminVerlorenId(String id) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/admin/setStatus/verloren/${id}");
    return result;
  }

//r.Get("/rest/admin/setExtension/:id/:value", http.HandlerFunc(setExtensionByID))

  Future<String> adminSetExtension(String id, String value) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/admin/setExtension/${id}/${value}");
    return result;
  }

  // RESERVIERUNG API

  //r.Get("/rest/reservierung/list/all", http.HandlerFunc(getAllReservierung))

  Future<List<Answer>> reservierungListAll() async {
    String result =
        await com.makeGetRequest(com.serverPort, "/rest/reservierung/list/all");

    List<Answer> liste = answerFromJson(result);
    return liste;
  }

  //r.Get("/rest/reservierung/list/all/date/:date", http.HandlerFunc(getReservierungByDate))

  Future<String> reservierungListAllDate(String date) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/reservierung/list/all/date/${date}");
    return result;
  }

  //r.Get("/rest/reservierung/list/date/:udid/:date", http.HandlerFunc(getReservierungByUdidDate))

  Future<String> reservierungListUdidDate(String udid, String date) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/reservierung/list/date/${udid}/${date}");
    return result;
  }

  //r.Get("/rest/reservierung/list/all/interval/:start/:ende", http.HandlerFunc(getReservierungByInterval))

  Future<String> reservierungListInterval(String start, String ende) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/reservierung/list/all/interval/${start}/${ende}");
    return result;
  }

  //r.Get("/rest/reservierung/list/:udid", http.HandlerFunc(getReservierungByUdid))

  Future<List<Answer>> reservierungListUdid(String udid) async {
    String result = await com.makeGetRequest(
        "${com.serverPort}", "/rest/reservierung/list/${udid}");

    List<Answer> liste = answerFromJson(result);
    return liste;
  }

  //r.Get("/rest/reservierung/delete/:udid", http.HandlerFunc(deleteReservierungByUdid))

  Future<String> reservierungDeleteUdid(String udid) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/reservierung/delete/${udid}");
    return result;
  }

  //r.Get("/rest/reservierung/delete/inventarnummer/:inventarnummer", http.HandlerFunc(deleteReservierungByIn))

  Future<String> reservierungDeleteInventarnummer(String inventarnummer) async {
    String result = await com.makeGetRequest(com.hostname,
        "/rest/reservierung/delete/inventarnummer/${inventarnummer}");
    return result;
  }

  // r.Get("/rest/reservierung/delete/id/:id", http.HandlerFunc(deleteReservierungByIn))

  Future<String> reservierungDeleteId(int id) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/reservierung/delete/id/${id}");
    return result;
  }

//r.Get("/rest/reservierung/add/:udid/:inventarnummer/:start/:ende", http.HandlerFunc(addReservierung))

  Future<String> reservierungAddUdidInventarnummer(
      String udid, String inventarnummer, String start, String ende) async {
    String result = await com.makeGetRequest("${com.serverName}:${com.port}",
        "/rest/reservierung/add/${udid}/${inventarnummer}/${start}/${ende}");

    return result;
  }

  // BELEGT API

  //r.Get("/rest/belegt/list/all", http.HandlerFunc(getAllBelegt))

  Future<String> belegtListAll() async {
    String result =
        await com.makeGetRequest(com.hostname, "/rest/belegt/list/all");
    return result;
  }

  //r.Get("/rest/belegt/list/all/date/:date", http.HandlerFunc(getBelegtByDate))

  Future<String> belegtListAllDate(String date) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/belegt/list/all/date/${date}");
    return result;
  }

  //r.Get("/rest/belegt/list/date/:udid/:date", http.HandlerFunc(getBelegtByUdidDate))

  Future<String> belegtListUdidDate(String udid, String date) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/belegt/list/date/${udid}/${date}");
    return result;
  }

  //r.Get("/rest/belegt/list/all/interval/:start/:ende", http.HandlerFunc(getBelegtByInterval))

  Future<String> belegtListInterval(String start, String ende) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/belegt/list/all/interval/${start}/${ende}");
    return result;
  }

  // r.Get("/rest/verliehen/list/all", http.HandlerFunc(getVerliehenAll))

  Future<String> verliehenListAll() async {
    String result =
        await com.makeGetRequest(com.hostname, "/rest/verliehen/list/all");
    return result;
  }

  //r.Get("/rest/verliehen/list/udid/:udid", http.HandlerFunc(getVerliehenByUdid))

  Future<String> verliehenListUdid(String udid) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/verliehen/list/udid/${udid}");
    return result;
  }

  //r.Get("/rest/verliehen/list/all/date/:date", http.HandlerFunc(getVerliehenByDate))

  Future<String> verliehenListAllDate(String date) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/verliehen/list/all/date/${date}");
    return result;
  }

  //r.Get("/rest/admin/setStatus/reserviert/:id", http.HandlerFunc(setStatusReserviertByID))

  Future<String> adminSetStatusReserviertById(int id) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/admin/setStatus/reserviert/${id}");
    return result;
  }

//r.Get("/rest/admin/setStatus/verliehen/:id", http.HandlerFunc(setStatusVerliehenByID))

  Future<String> adminSetStatusVerliehenById(int id) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/admin/setStatus/verliehen/${id}");
    return result;
  }

//r.Get("/rest/admin/setStatus/defekt/:id", http.HandlerFunc(setStatusDefektByID))

  Future<String> adminSetStatusDefektById(int id) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/admin/setStatus/defekt/${id}");
    return result;
  }

//r.Get("/rest/admin/setStatus/verloren/:id", http.HandlerFunc(setStatusVerlorenByID))

  Future<String> adminSetStatusVerlorenById(int id) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/admin/setStatus/verloren/${id}");
    return result;
  }

//r.Get("/rest/admin/setExtension/:id/:value", http.HandlerFunc(setExtensionByID))

  Future<String> adminSetExtensionById(int id, String value) async {
    String result = await com.makeGetRequest(
        com.hostname, "/rest/admin/setExtension/${id}/${value}");
    return result;
  }

  //r.Get("/rest/admin/isAdmin/:udid", http.HandlerFunc(getIsAdminByUdid))

  Future<bool> adminIsAdminByUdid(String udid) async {
    String answer =
        await com.makeGetRequest(com.hostname, "/rest/admin/isAdmin/${udid}");
    return (answer.trim() == 'true');
  }

  // UPLOAD, copy und create

  Future<String?> uploadImage(File file, String fname) async {
    var request =
        MultipartRequest('POST', Uri.parse(com.hostname + "/upload/upload"));
    request.files.add(
      MultipartFile.fromBytes(
        'myFile',
        file.readAsBytesSync(),
        filename: "EinBild",
      ),
    );
    request.fields['fname'] = fname;
    var res = await request.send();
    return res.reasonPhrase;
  }

  Future<String?> uploadString(String content, String fname) async {
    var request =
        MultipartRequest('POST', Uri.parse(com.hostname + "/upload/upload"));
    // TODO check Uint8List und List<int>
    //Uint8List bytes = utf8.encode(content);
    List<int> bytes = utf8.encode(content);

    request.files.add(
      MultipartFile.fromBytes(
        'myFile',
        bytes,
        filename: "EinString",
      ),
    );
    request.fields['fname'] = fname;
    var res = await request.send();
    return res.reasonPhrase;
  }

  Future<String?> recreateCatalog(String dataDir) async {
    var request = MultipartRequest(
        'POST', Uri.parse(com.hostname + "/rest/admin/catalog/recreate"));

    request.fields['datadir'] = dataDir;
    var res = await request.send();
    return res.reasonPhrase;
  }
}

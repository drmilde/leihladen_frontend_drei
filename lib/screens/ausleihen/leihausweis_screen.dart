import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leihladen_frontend_drei/config/screens/leihausweis_screen_config.dart';
import 'package:leihladen_frontend_drei/config/store.dart';
import 'package:leihladen_frontend_drei/model/data_model.dart';
import 'package:leihladen_frontend_drei/screens/ausleihen/qr_code_screen.dart';
import 'package:leihladen_frontend_drei/widgets/dynamic_scaffold.dart';

class LeihausweisScreen extends StatefulWidget {
  @override
  _LeihausweisScreenState createState() => _LeihausweisScreenState();
}

class _LeihausweisScreenState extends State<LeihausweisScreen> {
  LeihausweisScreenConfig config = LeihausweisScreenConfig();
  String UDID = "Ihre Ausweisnummer";

  TextEditingController _controllerNachname = TextEditingController();
  TextEditingController _controllerVorname = TextEditingController();
  TextEditingController _controllerAdresse = TextEditingController();
  TextEditingController _controllerMobile = TextEditingController();
  TextEditingController _controllerGeburtsjahr = TextEditingController();
  TextEditingController _controllerPasswort = TextEditingController();

  //ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //DataModel.loadStore();

    Leihausweis ausweis = DataModel.store.value.leihausweis;
    _controllerNachname.text = ausweis.nachname;
    _controllerVorname.text = ausweis.vorname;
    _controllerAdresse.text = ausweis.adresse;
    _controllerMobile.text = ausweis.mobile;
    _controllerGeburtsjahr.text = ausweis.geburtsjahr;
    _controllerPasswort.text = ausweis.passwort;

    _updateUdid();

    // reset to position 0
    // TODO reset to position 0
    /*
    if (mounted) {
      _scrollController.animateTo(_scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 10), curve: Curves.ease);
    }
     */
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _validateForm(callSetState: false);
  }

  @override
  Widget build(BuildContext context) {
    return DynamicScaffold(
      drawer: Container(),
      appbar: AppBar(
        title: Text("Leihausweis"),
      ),
      fab: Container(),
      showDrawer: false,
      showAppbar: false,
      showFab: false,
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Scaffold(
      appBar: AppBar(
        title: Text(config.getAppbarTitle()),
        centerTitle: false,
        backgroundColor: config.getPrimaryColor(),
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: _clearForm,
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _validateForm,
          ),
          IconButton(
            icon: Icon(Icons.qr_code),
            onPressed: () {
              _updateUdid();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => QrCodeScreen(
                  _createJsonObscured(),
                ),
              ));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              /*
            child: Text(
              "Füllen Sie bitte das Formular aus und erstellen Sie so Ihren digitalen Leihausweis."
              " Mit dem digitalen Leihausweis weisen Sie sich vor Ort im Leihladen aus."
              " Ihre Daten werden *NICHT* übertragen und ausschliesslich auf Ihrem Handy gespeichert."
              " Wir haben keinen Zugriff auf Ihrer personenbezogenen Daten."
              "\n\nIhre Ausweisnummer: ${UDID.hashCode}",
              textAlign: TextAlign.justify,
            ),
             */
              child: Container(
                child: Text(
                  "${config.getBeschreibungText()} \n\nAusweisnummer: ${UDID.hashCode}",
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                  ),
                ),
              )),
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: SingleChildScrollView(
              //controller: _scrollController,
              child: Container(
                child: Form(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (value) {
                            _updateUdid();
                          },
                          controller: _controllerNachname,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (value) {
                            _updateUdid();
                          },
                          controller: _controllerVorname,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Vorname',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (value) {
                            _updateUdid();
                          },
                          controller: _controllerAdresse,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Adresse',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (value) {
                            _updateUdid();
                          },
                          controller: _controllerMobile,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Wie erreichen wir Sie?",
                            labelText: 'Telefon/E-mail',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (value) {
                            _updateUdid();
                          },
                          controller: _controllerGeburtsjahr,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Geburtsjahr',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _controllerPasswort,
                          onChanged: (value) {
                            _updateUdid();
                          },
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Wählen Sie ein beliebiges Passwort.",
                            labelText: 'Passwort',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateUdid({bool callSteState = true}) {
    String name = _controllerNachname.text.trim();
    String vorname = _controllerVorname.text.trim();
    String adresse = _controllerAdresse.text.trim();
    String email = _controllerMobile.text.trim();
    String geburtsjahr = _controllerGeburtsjahr.text.trim();
    String passwort = _controllerPasswort.text.trim();
    UDID = "${name}:${vorname}:${adresse}:${email}:${geburtsjahr}:${passwort}";
    // update UI
    if (callSteState) {
      setState(() {});
    }
  }

  void _clearForm() {
    _controllerNachname.clear();
    _controllerVorname.clear();
    _controllerAdresse.clear();
    _controllerMobile.clear();
    _controllerGeburtsjahr.clear();
    _controllerPasswort.clear();
    _updateUdid();
  }

  void _validateForm({bool callSetState = true}) {
    if (!callSetState) {
      _saveData();
      return;
    }

    int err = 0;

    String name = _controllerNachname.text.trim();
    String vorname = _controllerVorname.text.trim();
    String adresse = _controllerAdresse.text.trim();
    String email = _controllerMobile.text.trim();
    String geburtsjahr = _controllerGeburtsjahr.text.trim();
    String passwort = _controllerPasswort.text.trim();

    if (name.isEmpty) {
      showMessage("Bitte geben Sie einen Namen ein");
      err++;
    }
    if (vorname.isEmpty) {
      showMessage("Bitte geben Sie einen Vornamen ein");
      err++;
    }
    if (adresse.isEmpty) {
      showMessage("Bitte geben Sie eine Adresse ein");
      err++;
    }
    if (email.isEmpty) {
      showMessage("Bitte geben Sie eine email ein");
      err++;
    }
    if (geburtsjahr.isEmpty) {
      showMessage("Bitte geben Sie Ihr Geburtsjahr ein");
      err++;
    }
    if (passwort.isEmpty) {
      showMessage("Bitte geben Sie ein Passwort ein");
      err++;
    }

    if (err > 0) {
      _popupValidationDialog(context);
    } else {
      _updateUdid(callSteState: callSetState);
      transmitData();
      _saveData();
      Navigator.of(context).pop();
    }
  }

  void showMessage(String msg) {
    //TODO NAchricht anzeigen
  }

  void _saveData() {
    DataModel.saveStore();
  }

  void transmitData() {
    DataModel.store.value.leihausweis.nachname = _controllerNachname.text.trim();
    DataModel.store.value.leihausweis.vorname = _controllerVorname.text.trim();
    DataModel.store.value.leihausweis.adresse = _controllerAdresse.text.trim();
    DataModel.store.value.leihausweis.mobile = _controllerMobile.text.trim();
    DataModel.store.value.leihausweis.geburtsjahr =
        _controllerGeburtsjahr.text.trim();
    DataModel.store.value.leihausweis.passwort = _controllerPasswort.text.trim();
    DataModel.store.value.leihausweis.udid = "${UDID.hashCode}";
  }

  _popupValidationDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Leihausweis nicht vollständig'),
            content: Text('Bitte füllen Sie den Leihausweis komplett aus.'
                ' Nur so können Sie Dinge ausleihen.'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok')),
            ],
          );
        });
  }

  String _createJsonObscured() {
    transmitData();
    return leihausweisToJsonObscured(DataModel.store.value.leihausweis);
  }
}

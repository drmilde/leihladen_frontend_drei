import 'package:flutter/material.dart';
import 'package:leihladen_frontend_drei/config/screens/auswaehlen_screen_config.dart';
import 'package:leihladen_frontend_drei/widgets/katalog_filtered_list_widget.dart';

class KatalogTabScreen extends StatefulWidget {
  AuswaehlenScreenConfig config = new AuswaehlenScreenConfig();
  List<KatalogFilteredListWidget> pages = [];
  int initialIndex = 0;

  KatalogTabScreen({this.initialIndex = 0}) {
    pages = [
      KatalogFilteredListWidget(
        kategorie: config.getKachelKategorie(1),
        title: config.getKachelText(1),
      ),
      KatalogFilteredListWidget(
        kategorie: config.getKachelKategorie(2),
        title: config.getKachelText(2),
      ),
      KatalogFilteredListWidget(
        kategorie: config.getKachelKategorie(3),
        title: config.getKachelText(3),
      ),
      KatalogFilteredListWidget(
        kategorie: config.getKachelKategorie(4),
        title: config.getKachelText(4),
      ),
      KatalogFilteredListWidget(
        kategorie: config.getKachelKategorie(5),
        title: config.getKachelText(5),
      ),
      KatalogFilteredListWidget(
        kategorie: config.getKachelKategorie(6),
        title: config.getKachelText(6),
      ),
      KatalogFilteredListWidget(
        kategorie: config.getKachelKategorie(7),
        title: config.getKachelText(7),
      ),
      KatalogFilteredListWidget(
        kategorie: config.getKachelKategorie(8),
        title: config.getKachelText(8),
      ),
      KatalogFilteredListWidget(
        kategorie: config.getKachelKategorie(9),
        title: config.getKachelText(9),
      ),
    ];
  }

  @override
  _KatalogTabScreenState createState() => _KatalogTabScreenState();
}

class _KatalogTabScreenState extends State<KatalogTabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = TabController(
      vsync: this,
      length: widget.pages.length,
      initialIndex: widget.initialIndex,
    );
  }


  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _controller,
      children: widget.pages.map<Widget>((Widget w) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Container(
            key: UniqueKey(),
            padding: const EdgeInsets.all(2.0),
            child: w,
          ),
        );
      }).toList(),
    );
  }
}

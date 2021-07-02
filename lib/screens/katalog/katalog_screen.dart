import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leihladen_frontend_drei/config/screens/katalog_screen_config.dart';
import 'package:leihladen_frontend_drei/screens/ausleihen/warenkorb_screen.dart';
import 'package:leihladen_frontend_drei/widgets/dynamic_scaffold.dart';
import 'package:leihladen_frontend_drei/widgets/katalog_filtered_list_widget.dart';
import 'package:leihladen_frontend_drei/widgets/search_widget.dart';

class KatalogScreen extends StatefulWidget {
  int kategorie = 0;
  String title = "Katalog";
  late KatalogFilteredListWidget listWidget;

  KatalogScreen({this.kategorie = 0, this.title = "Katalog"}) {
    listWidget = KatalogFilteredListWidget(
      kategorie: this.kategorie,
    );
  }

  @override
  _KatalogScreenState createState() => _KatalogScreenState();
}

class _KatalogScreenState extends State<KatalogScreen> {
  KatalogScreenConfig config = new KatalogScreenConfig();
  int sortState = 0; // no sorting
  bool showSearch = false;

  @override
  Widget build(BuildContext context) {
    return DynamicScaffold(
      drawer: Container(),
      showDrawer: false,
      appbar: AppBar(
        backgroundColor: config.getPrimaryColor(),
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              sortState = (sortState + 1) % 3;
              widget.listWidget.setSortState(sortState);
            },
            icon: Icon(Icons.sort),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                showSearch = !showSearch;
                if (!showSearch) {
                  widget.listWidget.setSearchTerm("");
                }
              });
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => WarenkorbScreen()));
            },
            icon: Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      fab: Container(),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        (showSearch)
            ? Container(
                //color: Colors.green,
                width: double.infinity,
                child: SearchWidget(
                  callback: (term) {
                    widget.listWidget.setSearchTerm(term);
                  },
                ),
              )
            : Container(),
        Expanded(
          child: widget.listWidget,
        ),
      ],
    );
  }
}

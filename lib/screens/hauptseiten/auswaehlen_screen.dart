import 'package:flutter/material.dart';
import 'package:leihladen_frontend_drei/config/screens/auswaehlen_screen_config.dart';
import 'package:leihladen_frontend_drei/screens/katalog/katalog_screen.dart';
import 'package:leihladen_frontend_drei/widgets/app_drawer_widget.dart';
import 'package:leihladen_frontend_drei/widgets/dynamic_scaffold.dart';
import 'package:leihladen_frontend_drei/widgets/kachel_widget.dart';

class AuswaehlenScreen extends StatefulWidget {
  @override
  _AuswaehlenScreenState createState() => _AuswaehlenScreenState();
}

class _AuswaehlenScreenState extends State<AuswaehlenScreen> {
  AuswaehlenScreenConfig config = new AuswaehlenScreenConfig();
  final key = UniqueKey();
  final lastItemKey = new GlobalKey();
  List<VoidCallback> callbacks = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callbacks = [
      () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => KatalogScreen(
              kategorie: config.getKachelKategorie(1),
              title: config.getKachelText(1),
            ),
          ),
        );
      },
      () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => KatalogScreen(
              kategorie: config.getKachelKategorie(2),
              title: config.getKachelText(2),
            ),
          ),
        );
      },
      () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => KatalogScreen(
              kategorie: config.getKachelKategorie(3),
              title: config.getKachelText(3),
            ),
          ),
        );
      },
      () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => KatalogScreen(
              kategorie: config.getKachelKategorie(4),
              title: config.getKachelText(4),
            ),
          ),
        );
      },
      () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => KatalogScreen(
              kategorie: config.getKachelKategorie(5),
              title: config.getKachelText(5),
            ),
          ),
        );
      },
      () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => KatalogScreen(
              kategorie: config.getKachelKategorie(6),
              title: config.getKachelText(6),
            ),
          ),
        );
      },
      () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => KatalogScreen(
              kategorie: config.getKachelKategorie(7),
              title: config.getKachelText(7),
            ),
          ),
        );
      },
      () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => KatalogScreen(
              kategorie: config.getKachelKategorie(8),
              title: config.getKachelText(8),
            ),
          ),
        );
      },
      () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => KatalogScreen(
              kategorie: config.getKachelKategorie(9),
              title: config.getKachelText(9),
            ),
          ),
        );
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DynamicScaffold(
      drawer: Container(),
      appbar: AppBar(
        title: Text("Auswählen"),
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
      endDrawer: AppDrawerWidget(),
      body: CustomScrollView(
        key: key,
        slivers: [
          SliverAppBar(
            centerTitle: true,
            pinned: true,
            expandedHeight: 170 + 64,
            backgroundColor: config.getPrimaryColor(),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(config.getAppbarTitle()),
              background: Container(
                height: 234,
                width: 500,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(config.getHeaderImageUrl()),
                )),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                  config.getBeschreibungText(),
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          _createSliverGrid(),
        ],
      ),
    );
  }

  Widget _createSliverGrid() {
    int crossCount = 3;
    return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          ///no.of items in the horizontal axis
          crossAxisCount: crossCount,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),

        ///Lazy building of list
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return listItem(
              config.getPrimaryColor(),
              index,
              crossCount,
              addKey: (index >= 8),
            );
          },

          /// Set childCount to limit no.of items
          childCount: 9,
        ));
  }

  Widget listItem(Color color, int index, int crossCount,
      {bool addKey = false}) {
    int columNr = (index % crossCount);

    //print("${index}, ${addKey}");

    switch (columNr) {
      case 0:
        return Container(
          key: (addKey) ? lastItemKey : UniqueKey(),
          color: Colors.white,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, top: 8, right: 4),
              child: KachelWidget(
                color,
                config.getKachelText(index + 1),
                index,
                config.getKachelIcon(index + 1),
                callback: callbacks[index],
              ),
            ),
          ),
        );
      case 2: // muss crosscount - 1 sein, also hier 2
        return Container(
          color: Colors.white,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 4, top: 8, right: 8),
              child: KachelWidget(
                color,
                config.getKachelText(index + 1),
                index,
                config.getKachelIcon(index + 1),
                callback: callbacks[index],
              ),
            ),
          ),
        );
      default:
        return Container(
          color: Colors.white,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 4, top: 8, right: 4),
              child: KachelWidget(
                color,
                config.getKachelText(index + 1),
                index,
                config.getKachelIcon(index + 1),
                callback: callbacks[index],
              ),
            ),
          ),
        );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:leihladen_frontend_drei/config/screens/mitmachen_screen_config.dart';
import 'package:leihladen_frontend_drei/screens/katalog/katalog_screen.dart';
import 'package:leihladen_frontend_drei/screens/mitmachen/fragen_screen.dart';
import 'package:leihladen_frontend_drei/screens/mitmachen/neuigkeiten_screen.dart';
import 'package:leihladen_frontend_drei/screens/mitmachen/vorschlaege_screen.dart';
import 'package:leihladen_frontend_drei/screens/mitmachen/wunschliste_screen.dart';
import 'package:leihladen_frontend_drei/widgets/app_drawer_widget.dart';
import 'package:leihladen_frontend_drei/widgets/dynamic_scaffold.dart';
import 'package:leihladen_frontend_drei/widgets/kachel_widget.dart';

class MitmachenScreen extends StatefulWidget {
  @override
  _MitmachenScreenState createState() => _MitmachenScreenState();
}

class _MitmachenScreenState extends State<MitmachenScreen> {
  MitmachenScreenConfig config = new MitmachenScreenConfig();
  final key = UniqueKey();
  List<VoidCallback> callbacks = [];
  bool isSmall = false;
  double smallSize = 115;

  @override
  void initState() {
    super.initState();
    callbacks = [
      () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => NeuigkeitenScreen()));
      },
      () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => WunschlisteScreen()));
      },
      () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => VorschlaegeScreen()));
      },
      () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => FragenScreen()));
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    isSmall = (MediaQuery.of(context).size.height < 700);
    smallSize = (MediaQuery.of(context).size.height < 600)? 0: 115;
    return DynamicScaffold(
      drawer: Container(),
      appbar: AppBar(
        title: Text("Mitmachen"),
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
            expandedHeight: isSmall? (smallSize): (170 + 64),
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
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          _createSliverGrid()
        ],
      ),
    );
  }

  Widget _createSliverGrid() {
    int crossCount = 2;
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
            /// To convert this infinite list to a list with "n" no of items,
            /// uncomment the following line:
            /// if (index > n) return null;
            return listItem(config.getPrimaryColor(), index, crossCount);
          },

          /// Set childCount to limit no.of items
          childCount: 4,
        ));
  }

  Widget listItem(Color color, int index, int crossCount) {
    int columNr = (index % crossCount);

    switch (columNr) {
      case 0:
        return Container(
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
      case 1: // muss crosscount - 1 sein, also hier 2
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

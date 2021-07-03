import 'package:flutter/material.dart';
import 'package:leihladen_frontend_drei/config/screens/ausleihen_config_screen.dart';
import 'package:leihladen_frontend_drei/screens/ausleihen/entliehen_screen.dart';
import 'package:leihladen_frontend_drei/screens/ausleihen/leihausweis_screen.dart';
import 'package:leihladen_frontend_drei/screens/ausleihen/reservierung_screen.dart';
import 'package:leihladen_frontend_drei/screens/ausleihen/warenkorb_screen.dart';
import 'package:leihladen_frontend_drei/widgets/app_drawer_widget.dart';
import 'package:leihladen_frontend_drei/widgets/dynamic_scaffold.dart';
import 'package:leihladen_frontend_drei/widgets/kachel_widget.dart';

class AusleihenScreen extends StatefulWidget {
  @override
  _AusleihenScreenState createState() => _AusleihenScreenState();
}

class _AusleihenScreenState extends State<AusleihenScreen> {
  AusleihenScreenConfig config = new AusleihenScreenConfig();
  final key = UniqueKey();
  List<VoidCallback> callbacks = [];
  bool isSmall = false;

  @override
  void initState() {
    super.initState();
    callbacks = [
      () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LeihausweisScreen()));
      },
      () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => WarenkorbScreen()));
      },
      () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ReservierungScreen()));
      },
      () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => EntliehenScreen()));
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    isSmall = (MediaQuery.of(context).size.height < 700);
    return DynamicScaffold(
      drawer: Container(),
      appbar: AppBar(
        title: Text("Ausleihen"),
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
            expandedHeight: isSmall ? (115) : (170 + 64),
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

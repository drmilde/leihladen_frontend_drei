import 'package:flutter/material.dart';
import 'package:leihladen_frontend_drei/config/screens/auswaehlen_screen_config.dart';
import 'package:leihladen_frontend_drei/screens/katalog/katalog_screen.dart';
import 'package:leihladen_frontend_drei/widgets/dynamic_scaffold.dart';
import 'package:leihladen_frontend_drei/widgets/kachel_widget.dart';

class AuswaehlenScreen extends StatefulWidget {
  @override
  _AuswaehlenScreenState createState() => _AuswaehlenScreenState();
}

class _AuswaehlenScreenState extends State<AuswaehlenScreen> {
  AuswaehlenScreenConfig config = new AuswaehlenScreenConfig();
  final key = UniqueKey();
  List<VoidCallback> callbacks = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callbacks = [
      () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => KatalogScreen()));
      },
      () {},
      () {},
      () {},
      () {},
      () {},
      () {},
      () {},
      () {},
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
      body: CustomScrollView(
        key: key,
        slivers: [
          SliverAppBar(
            centerTitle: true,
            pinned: true,
            expandedHeight: 170 + 64,
            backgroundColor: config.getPrimaryColor(),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
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
            /// To convert this infinite list to a list with "n" no of items,
            /// uncomment the following line:
            /// if (index > n) return null;
            return listItem(config.getPrimaryColor(), index, crossCount);
          },

          /// Set childCount to limit no.of items
          childCount: 9,
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

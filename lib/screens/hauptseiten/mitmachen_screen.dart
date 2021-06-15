import 'package:flutter/material.dart';
import 'package:leihladen_frontend_drei/config/screens/ausleihen_config_screen.dart';
import 'package:leihladen_frontend_drei/config/screens/mitmachen_screen_config.dart';
import 'package:leihladen_frontend_drei/widgets/dynamic_scaffold.dart';

class MitmachenScreen extends StatelessWidget {
  MitmachenScreenConfig config = new MitmachenScreenConfig();
  final key = UniqueKey();

  @override
  Widget build(BuildContext context) {
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return _getContent(index);
              },
              childCount: 25,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getContent(int index) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Mitmachen mach Spass",
          textAlign: TextAlign.justify,
          style: TextStyle(),
        ),
      ),
    );
  }
}

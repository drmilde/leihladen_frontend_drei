import 'package:flutter/material.dart';
import 'package:leihladen_frontend_drei/config/screens/home_screen_config.dart';
import 'package:leihladen_frontend_drei/widgets/bottom_navigation_bar_widget.dart';
import 'package:leihladen_frontend_drei/widgets/dynamic_scaffold.dart';

class HomeScreen extends StatelessWidget {
  HomeScreenConfig config = new HomeScreenConfig();
  final key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return DynamicScaffold(
      drawer: Container(),
      appbar: AppBar(
        title: Text("Katalogliste"),
      ),
      fab: Container(),
      showDrawer: false,
      showAppbar: false,
      showFab: false,
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    String inhalt = "jfh dfkjdshf kjdsf fdh sdkhkfs"
        " kkfdsh dfsjkh sfkjh sdf sf jkdsf ksdfh sjkfh kjsdhf"
        " kjhsdf sfd ksdfjh sdfkjhsdf kjhsf kjhdsf sdf sdkjh"
        " sdfkjsdfh kjsfdh kjhdf s sfdjkhsdf kjdsfh ksdfjh sdfj fs";

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
                return Container(
                  height: 100,
                  child: Text(inhalt),
                );
              },
              childCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}

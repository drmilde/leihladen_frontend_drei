import 'package:flutter/material.dart';
import 'package:leihladen_frontend_drei/config/screens/home_screen_config.dart';
import 'package:leihladen_frontend_drei/widgets/app_drawer_widget.dart';
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _getContent(index);
              },
              childCount: 5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getContent(int index) {
    if (index == 3) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 234,
          width: 500,
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(config.getLagerImageUrl()),
          )),
        ),
      );
    }
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          config.getText(index),
          textAlign: TextAlign.justify,
          style: TextStyle(),
        ),
      ),
    );
  }
}

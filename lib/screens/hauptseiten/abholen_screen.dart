import 'package:flutter/material.dart';
import 'package:leihladen_frontend_drei/config/screens/abholen_screen_config.dart';

class AbholenScreen extends StatelessWidget {
  AbholenScreenConfig config = AbholenScreenConfig();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          centerTitle: false,
          pinned: true,
          expandedHeight: 170 + 64,
          //title: Text("Abholen"),
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
        //_buildBody(),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                height: 700,
                width: 500,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(config.getMapImageUrl()),
                    )),
              );
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }
}

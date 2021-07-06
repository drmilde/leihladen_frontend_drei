import 'package:flutter/material.dart';
import 'package:leihladen_frontend_drei/config/screens/abholen_screen_config.dart';
import 'package:leihladen_frontend_drei/screens/abholen/laden_info_screen.dart';
import 'package:leihladen_frontend_drei/widgets/app_drawer_widget.dart';

class AbholenScreen extends StatelessWidget {
  AbholenScreenConfig config = AbholenScreenConfig();
  bool isSmall = false;

  @override
  Widget build(BuildContext context) {
    isSmall = (MediaQuery.of(context).size.height < 700);
    return Scaffold(
      endDrawer: AppDrawerWidget(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: false,
            pinned: true,
            expandedHeight: isSmall? (115): (170 + 64),
            //title: Text("Abholen"),
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
          //_buildBody(),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LadenInfoScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 700,
                    width: 500,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(config.getMapImageUrl()),
                    )),
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

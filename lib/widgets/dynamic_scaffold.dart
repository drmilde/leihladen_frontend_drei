import 'package:flutter/material.dart';

class DynamicScaffold extends StatefulWidget {
  Widget drawer;
  PreferredSizeWidget appbar;
  Widget body;
  Widget fab;
  bool showFab = false;

  double maxWidth = 600;
  double centerColumnWidth = 420;

  bool showDrawer = true;
  bool showAppbar = true;

  DynamicScaffold({
    required this.drawer,
    required this.appbar,
    required this.body,
    required this.fab,
    this.showFab = false,
    this.showAppbar = true,
    this.maxWidth = 600,
    this.centerColumnWidth = 420,
    this.showDrawer = true,
  });

  @override
  _DynamicScaffoldState createState() => _DynamicScaffoldState();
}

class _DynamicScaffoldState extends State<DynamicScaffold> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > widget.centerColumnWidth) {
          return wideScaffold();
        } else {
          return narrowScaffold();
        }
      },
    );
  }

  Widget narrowScaffold() {
    return Scaffold(
      appBar: widget.showAppbar ? widget.appbar : null,
      endDrawer: widget.showDrawer ? widget.drawer : null,
      body: widget.body,
      floatingActionButton: widget.showFab ? widget.fab : null,
    );
  }

  Widget wideScaffold() {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              color: Colors.teal[200],
            ),
          ),
          Container(
            width: widget.centerColumnWidth,
            child: narrowScaffold(),
          ),
          Expanded(
            child: Container(
              color: Colors.amberAccent[200],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:leihladen_frontend_drei/widgets/bottom_navigation_bar_widget.dart';
import 'package:leihladen_frontend_drei/widgets/dynamic_scaffold.dart';

import 'home_screen.dart';

class HauptSeiteScreen extends StatefulWidget {
  late _HauptSeiteScreenState _state;
  @override
  _HauptSeiteScreenState createState() {
    _state = _HauptSeiteScreenState();
    return _state;
  }

  void setSelectedIndex (int index) {
    _state.setSelectedIndex(index);
  }
}

class _HauptSeiteScreenState extends State<HauptSeiteScreen> {
  int _selectedScreen = 0;
  List<Widget> screens = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen()
  ];

  void setSelectedIndex(int index) {
    setState(() {
      _selectedScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DynamicScaffold(
      drawer: Container(),
      appbar: AppBar(
        title: Text("Hauptseite"),
      ),
      fab: Container(),
      showDrawer: false,
      showAppbar: false,
      showFab: false,
      body: Scaffold(
        bottomNavigationBar: BottomNavigationBarWidget(
          currentIndex: 0,
          hauptSeite: widget,
        ),
        body: screens[_selectedScreen],
      ),
    );
  }
}

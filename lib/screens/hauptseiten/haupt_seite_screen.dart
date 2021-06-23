import 'package:flutter/material.dart';
import 'package:leihladen_frontend_drei/config/screens/hauptseiten_config.dart';
import 'package:leihladen_frontend_drei/screens/abholen/laden_info_screen.dart';
import 'package:leihladen_frontend_drei/screens/hauptseiten/abholen_screen.dart';
import 'package:leihladen_frontend_drei/screens/hauptseiten/ausleihen_screen.dart';
import 'package:leihladen_frontend_drei/screens/hauptseiten/auswaehlen_screen.dart';
import 'package:leihladen_frontend_drei/screens/hauptseiten/mitmachen_screen.dart';
import 'package:leihladen_frontend_drei/screens/start_screen.dart';
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

  void setSelectedIndex(int index) {
    _state.setSelectedIndex(index);
  }
}

class _HauptSeiteScreenState extends State<HauptSeiteScreen> {
  HauptseitenConfig config = new HauptseitenConfig();

  int _selectedScreen = 0;
  bool firstTime = true;
  List<Widget> screens = [
    HomeScreen(),
    AuswaehlenScreen(),
    AusleihenScreen(),
    AbholenScreen(),
    MitmachenScreen()
  ];

  List<FloatingActionButton?> floatActionButtons = [
    null,
    null,
    null,
    null,
    null,
  ];

  void setSelectedIndex(int index) {
    setState(() {
      _selectedScreen = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // setzen des Info Buttons für Screen 3: AbholenScreen
    floatActionButtons[3] = FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LadenInfoScreen()));
      },
      child: Text("Info", style: TextStyle(color: Colors.white)),
      backgroundColor: config.getPrimaryColor(),
    );
    firstTime = false;
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
          currentIndex: _selectedScreen,
          hauptSeite: widget,
        ),
        floatingActionButton: floatActionButtons[_selectedScreen],
        body: screens[_selectedScreen],
      ),
    );
  }
}

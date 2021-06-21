import 'package:flutter/material.dart';
import 'package:leihladen_frontend_drei/config/screens/bottom_navigation_bar_widget_config.dart';
import 'package:leihladen_frontend_drei/screens/hauptseiten/haupt_seite_screen.dart';
import 'package:leihladen_frontend_drei/screens/hauptseiten/home_screen.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  int currentIndex = 0;
  HauptSeiteScreen hauptSeite;

  BottomNavigationBarWidget(
      {required this.currentIndex, required this.hauptSeite});

  @override
  _BottomNavigationBarWidgetState createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  BottomNavigationBarWidgetConfig config = BottomNavigationBarWidgetConfig();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: widget.currentIndex,
      selectedIconTheme: IconThemeData(
        //color: Theme.of(context).primaryColorDark,
        color: config.getPrimaryColorDark(),
        size: 30,
      ),
      selectedItemColor: config.getPrimaryColorDark(),
      onTap: (int index) {
        setState(() {
          widget.currentIndex = index;
          widget.hauptSeite.setSelectedIndex(index);
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          title: Text("Home"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.store_outlined),
          title: Text("Auswählen"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_run_outlined),
          title: Text("Ausleihen"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map_outlined),
          title: Text("Abholen"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group_outlined),
          title: Text("Mitmachen"),
        ),
      ],
    );
  }
}

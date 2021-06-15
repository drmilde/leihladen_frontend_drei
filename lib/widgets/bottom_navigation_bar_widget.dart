import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: widget.currentIndex,
      selectedIconTheme: IconThemeData(
        color: Theme.of(context).primaryColorDark,
        size: 30,
      ),
      selectedItemColor: Theme.of(context).primaryColorDark,
      onTap: (int index) {
        setState(() {
          widget.currentIndex = index;
          widget.hauptSeite.setSelectedIndex(index);
          // TODO auf index reagieren
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          title: Text("Home"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.store),
          title: Text("Auswählen"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_run),
          title: Text("Ausleihen"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text("Abholen"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          title: Text("Mitmachen"),
        ),
      ],
    );
  }
}

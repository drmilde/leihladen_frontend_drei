import 'package:flutter/material.dart';
import 'screens/loader/loader_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Leihladen Frontend 3',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoaderScreen(),
    );
  }
}



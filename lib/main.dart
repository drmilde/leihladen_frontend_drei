import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leihladen_frontend_drei/config/color_config.dart';
import 'package:leihladen_frontend_drei/model/data_model.dart';
import 'package:leihladen_frontend_drei/screens/loader/boot_loader_screen.dart';
import 'screens/loader/data_loader_screen.dart';

void main() {
  final DataModel dm = Get.put(DataModel());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Leihladen Frontend 3',
      theme: new ThemeData(
        primaryColor: ColorConfig.fromHex("#FF35ac57"),
        primaryColorDark: ColorConfig.fromHex("#FF23733a"),
        accentColor: ColorConfig.fromHex("#FF82fcd7"),
        scaffoldBackgroundColor: ColorConfig.fromHex("#FFFFFFFF"),
        bottomAppBarColor: ColorConfig.fromHex("#FFEEEEEE"),
      ),
      home: BootLoaderScreen(),
    );
  }
}



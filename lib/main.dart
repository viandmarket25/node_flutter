import 'dart:io';

import 'package:flutter/material.dart';
import 'package:statusbar/statusbar.dart';
import 'pages/splashScreen.dart';
import 'package:flutter_statusbar_text_color/flutter_statusbar_text_color.dart';
import 'package:statusbar/statusbar.dart';
import 'package:camera/camera.dart';
import 'package:http_proxy/http_proxy.dart';

List<CameraDescription> cameras=[];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //cameras = await availableCameras();
    WidgetsFlutterBinding.ensureInitialized();
    HttpProxy httpProxy = await HttpProxy.createHttpProxy();
    HttpOverrides.global=httpProxy;
   // runApp(MyApp());
    runApp(MyScaffold());


}
//https://mirrors.tuna.tsinghua.edu.cn/dart-pub/
//int _selectedIndex=0;
class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //print("main: "+cameras.toString());
    //----------status bar color settings here-------
    /***
     * change status bar background color
     * **/
    //StatusBar.color(Colors.grey[50]);


    /***
     * change status bar content  color
     * **/
    FlutterStatusbarTextColor.setTextColor(FlutterStatusbarTextColor.light);
    //FlutterStatusbarTextColor.setTextColor(FlutterStatusbarTextColor.light);
    //Material is a conceptual piece of paper on which the UI appears.
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      theme:ThemeData(
        bottomSheetTheme: BottomSheetThemeData(
          //backgroundColor: Colors.black.withOpacity(0.1)
        ),
        ),
      home: ScreenSplash( key: UniqueKey()),

    );
  }
}





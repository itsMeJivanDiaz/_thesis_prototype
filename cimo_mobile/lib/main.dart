import 'package:cimo_mobile/home.dart';
import 'package:cimo_mobile/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xff86e3ce),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => LoadingView(),
    },
  ));
}

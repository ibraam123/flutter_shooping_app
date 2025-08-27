import 'package:flutter/material.dart';
import 'package:flutter_shooping_app/view/start_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Suwannaphum",
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const StartView(),
    );
  }
}

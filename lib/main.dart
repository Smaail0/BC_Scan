import 'package:flutter/material.dart';
import 'package:scan/barcode_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scanner de Code-Barres',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BarcodeScannerScreen(),
    );
  }
}

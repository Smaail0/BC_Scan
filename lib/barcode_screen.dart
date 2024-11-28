import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

class BarcodeScannerScreen extends StatefulWidget {
  @override
  _BarcodeScannerScreenState createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  String scanResult = 'Aucun code scanné pour le moment';

  Future<void> startBarcodeScan() async {
    try {
      ScanResult result = await BarcodeScanner.scan();
      setState(() {
        scanResult = result.rawContent.isEmpty
            ? 'Aucun code détecté'
            : 'Code scanné : $result';
      });
    } catch (e) {
      setState(() {
        scanResult = 'Erreur lors du scan : $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanner de Code-Barres'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              scanResult,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: startBarcodeScan,
              child: Text('Scanner un code-barres'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Pour encoder les données JSON

class QRCodeScannerScreen extends StatefulWidget {
  @override
  _QRCodeScannerScreenState createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  String scanResult = 'Aucun QR code scanné pour le moment';
  bool isLoading = false;

  Future<void> startQRScan() async {
    try {
      // Scanner un QR code
      ScanResult result = await BarcodeScanner.scan();
      String scannedData = result.rawContent;

      if (scannedData.isEmpty) {
        setState(() {
          scanResult = 'Aucun QR code détecté';
        });
        return;
      }

      setState(() {
        scanResult = 'QR code scanné : $scannedData';
      });

      // Envoyer les données à l'API
      await sendDataToAPI(scannedData);
    } catch (e) {
      setState(() {
        scanResult = 'Erreur lors du scan : $e';
      });
    }
  }

  Future<void> sendDataToAPI(String data) async {
    setState(() {
      isLoading = true;
    });

    // URL de l'API cible
    const String apiUrl = 'https://votre-api-url.com/endpoint';

    // Préparer les données à envoyer
    Map<String, String> body = {
      'scanned_data': data,
      'timestamp': DateTime.now().toIso8601String(), // Format ISO 8601
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        setState(() {
          scanResult = 'Les données ont été envoyées avec succès !';
        });
      } else {
        setState(() {
          scanResult =
              'Erreur lors de l\'envoi des données : ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        scanResult = 'Erreur réseau : $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanner de QR Code'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              CircularProgressIndicator()
            else
              Text(
                scanResult,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: startQRScan,
              child: Text('Scanner un QR code'),
            ),
          ],
        ),
      ),
    );
  }
}

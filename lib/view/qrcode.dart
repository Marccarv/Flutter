// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCode extends StatefulWidget {
  const QRCode({Key? key}) : super(key: key);

  @override
  _QRCodeState createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {
  final String data = "12345678";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Código QR"),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Código Gerado com o texto:\n $data",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              QrImage(
                data: data,
                size: 200,
                gapless: true,
                errorCorrectionLevel: QrErrorCorrectLevel.Q,
                //foregroundColor: Colors.white,
                //backgroundColor: Colors.black,
              )
            ],
          ),
        ));
  }
}

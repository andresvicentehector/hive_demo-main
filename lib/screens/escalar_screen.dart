import 'package:flutter/material.dart';
import 'package:sunboards_vuit/models/via.dart';
import 'package:sunboards_vuit/utils/escalar_via_form.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';



class EscalarScreen extends StatelessWidget {
  final int index;
  final Via via;
  final BluetoothDevice? server;


  const EscalarScreen({
    required this.index,
    required this.via,
    required this.server,

  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Escala esta via', style: TextStyle(fontFamily: 'November')),
      ),
      body: SingleChildScrollView(
      child:
        Padding(
        padding: const EdgeInsets.all(16.0),
        child: EscalarVia(
          index: index,
          via: via,
          server:server


        ),
      ),



    )

    );
  }
}

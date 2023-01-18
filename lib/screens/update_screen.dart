import 'package:flutter/material.dart';
import 'package:sunboards_vuit/models/via.dart';
import 'package:sunboards_vuit/utils/update_via_form.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';



class UpdateScreen extends StatelessWidget {
  final int index;
   final Via via;
   final List<String> presas;


  const UpdateScreen({
    required this.index,
    required this.via,
    required this.presas,

  });

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Actualizar una via',style: TextStyle(fontFamily: 'November')),
      ),
      body: SingleChildScrollView(


        child:

          Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                child:UpdateViaForm(
                index: index,
                via: via,
                presas: presas
                ),
                )
                ),




      ));

  }
}

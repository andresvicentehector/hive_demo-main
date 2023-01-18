import 'package:flutter/material.dart';
import 'package:sunboards_vuit/utils/add_via_form.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';


class AddScreen extends StatelessWidget {

  final List<String> presas;
  const AddScreen({

      required this.presas,

  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Añadir una nueva vía', style: TextStyle(fontFamily: 'November')),
      ),
      body:SingleChildScrollView(
         child:
          Padding (
              padding: const EdgeInsets.fromLTRB(8.0, 40.0, 8.0, 10.0),
              child: AddViaForm(presas: presas,)),

        ),
      );
  }
}

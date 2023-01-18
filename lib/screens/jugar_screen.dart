import 'package:flutter/material.dart';

import 'package:sunboards_vuit/screens/Bluetooth_screen.dart';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:sunboards_vuit/screens/add_via_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sunboards_vuit/screens/info_screen.dart';
import 'package:sunboards_vuit/template/ConstantesPropias.dart';



import 'package:sunboards_vuit/template/T1Colors.dart';
import 'package:sunboards_vuit/template/T8Colors.dart';
import 'package:sunboards_vuit/template/utils/T8Constant.dart';


import 'package:sunboards_vuit/template/T1Images.dart';
import 'package:sunboards_vuit/utils/Kimo.dart';
import 'package:sunboards_vuit/utils/Dictado.dart';

import 'package:sunboards_vuit/utils/bluetooth/SelectBondedDevicePage.dart';



class JugarScreen extends StatelessWidget {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  var isSelected = 3;
  Widget kimo= Container();
  late var width;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    if(version=="25"){
      kimo= InkWell(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                SizedBox(
                  height: 100,
                  width: 500,
                  child:
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Kimo-Game", style: TextStyle( fontSize: textSizeSMedium)),
                          Text("Kimo", style: TextStyle(fontFamily: fontMedium)),
                        ],
                      ),
                      SizedBox(width: 15),
                      Flexible(child: Text("Llega a la siguiente presa antes de que se acabe el tiempo. Este juego fue diseñado para la pared de 25 grados, así que debes conectarte a ella para poder jugar",maxLines: 4),),






                    ],
                  ),),

                SizedBox(height: 14),

                GestureDetector(
                  onTap:  ()  async {
                    final BluetoothDevice? selectedDevice =
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return SelectBondedDevicePage(checkAvailability: false);
                        },
                      ),
                    );
                    if(selectedDevice!=null){
                      _startChat(context, selectedDevice);
                    }

                  },
                  child: Container(
                      decoration: BoxDecoration(color:  t8_colorPrimary, borderRadius: BorderRadius.circular(16)),
                      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Center(
                            child:  Text( "Jugar", style: TextStyle(color: t8_white, fontFamily: "November", )),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(

                              width: 35,
                              height: 35,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.arrow_forward ,
                                  color: t8_white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                )
              ],
            ),

          )



      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Juegos disponibles', style: TextStyle(fontFamily: 'November')),
      ),
      body: SingleChildScrollView(
           child:
             Column(children: [

               kimo,

               dictadoInfo(context),

             ],
             ),





            )

    );
  }

  void _startChat(BuildContext context, BluetoothDevice server) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ChatPageKimo(server: server);
        },
      ),
    );
  }

  void _startDictado(BuildContext context, BluetoothDevice server){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return Dictado(server:server);
      })
    );
  }

  Widget dictadoInfo(BuildContext context){
    return InkWell(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              SizedBox(
                height: 100,
                width: 500,
                child:
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Modo-Dictado", style: TextStyle( fontSize: textSizeSMedium)),
                        Text("Dictado", style: TextStyle(fontFamily: fontMedium)),
                      ],
                    ),
                    SizedBox(width: 15),
                    Flexible(child: Text("Selecciona la presa que quieres que se ilumine en la tablet para que la persona que esté escalando pueda alcanzarla",maxLines: 4),),






                  ],
                ),),

              SizedBox(height: 14),

              GestureDetector(
                onTap:  ()  async {
                  final BluetoothDevice? selectedDevice =
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return SelectBondedDevicePage(checkAvailability: false);
                      },
                    ),
                  );
                  if(selectedDevice !=null){
                    _startDictado(context,selectedDevice);
                  }

                },
                child: Container(
                    decoration: BoxDecoration(color:  t8_colorPrimary, borderRadius: BorderRadius.circular(16)),
                    padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Center(
                          child:  Text( "Iniciar", style: TextStyle(color: t8_white, fontFamily: "November", )),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(

                            width: 35,
                            height: 35,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.arrow_forward ,
                                color: t8_white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),

        )



    );
  }
}











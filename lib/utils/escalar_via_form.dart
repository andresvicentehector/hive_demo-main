
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sunboards_vuit/models/via.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:sunboards_vuit/screens/edit_presas_screen.dart';
import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:sunboards_vuit/template/T8Colors.dart';
import 'package:sunboards_vuit/template/utils/T8Constant.dart';
import 'package:hive_flutter/hive_flutter.dart';


class EscalarVia extends StatefulWidget {
  final int index;
  final Via via;
  final BluetoothDevice? server;


  const EscalarVia({
    required this.index,
    required this.via,
    required this.server,

  });

  @override
  _EscalarViaState createState() => _EscalarViaState();
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _EscalarViaState extends State<EscalarVia> {

  late final _nameController;
  late final _autorController;
  late final _dificultadController;
  late final _comentarioController;
  late final _presasController;
  late final _numPresasController;
  late final Box box;
  late var width;
  late var height;

  static final clientID = 0;
  BluetoothConnection? connection;

  List<_Message> messages = List<_Message>.empty(growable: true);
  String _messageBuffer = '';

  final TextEditingController textEditingController =
  new TextEditingController();
  //final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);

  bool isDisconnecting = false;



  @override
  void initState() {
    super.initState();
    // Get reference to an already opened box
    box = Hive.box('Viabox');
    _nameController = widget.via.name;
    _autorController = widget.via.autor;
    _dificultadController = widget.via.dificultad;
    _comentarioController = Text(widget.via.comentario);
    _numPresasController= widget.via.presas.length;
    _presasController = Text(widget.via.presas.join("  "));


      BluetoothConnection.toAddress(widget.server!.address).then((_connection) {
        print('Connected to the device');
        connection = _connection;
        setState(() {
          isConnecting = false;
          isDisconnecting = false;
        });

        connection!.input!.listen(_onDataReceived).onDone(() {

          if (isDisconnecting) {
            print('Disconnecting locally!');
          } else {
            print('Disconnected remotely!');
          }
          if (this.mounted) {
            setState(() {});
          }
        });
      }).catchError((error) {
        print('Cannot connect, exception occured');
        print(error);
      });




  }

  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;


    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: Color(_dificultadController)),

              width: width / 6.5,
              height: width / 6.5,
              padding: EdgeInsets.all(10),


            ),
            SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(_nameController,style: TextStyle(color: Colors.white54, fontSize: textSizeSMedium), ),
                Text(_autorController,style: TextStyle(fontFamily: fontMedium), ),
                Text(_numPresasController.toString()+" presas", style: TextStyle(fontFamily: fontMedium)),
              ],
            ),
            SizedBox(width: 15),

          ],
        ),

        SizedBox(height: 20.0),
        //Text('Comentarios'),
        _comentarioController,
        SizedBox(height: 20.0),


        GestureDetector(
          onTap:  () async {

        if(isConnected==true){
          await _cargarViaTroncho(widget.via.presas);


        }

        },
          child: Container(
              decoration: BoxDecoration(color: (isConnected? t8_colorPrimary: t8_textColorSecondary),borderRadius: BorderRadius.circular(16) ),
              padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Center(
                    child:  Text( (isConnected? "Cargar vía": "Conéctate a la pared" ), style: TextStyle(color: t8_white, fontFamily: "November", )),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(

                      width: 35,
                      height: 35,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          isConnected? Icons.arrow_forward : Icons.arrow_upward,
                          color: t8_white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),

        SizedBox(height: 20.0),

        SizedBox(height: 20.0),


        Center(
          //widthFactor: 40,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0.0, 0, 24.0),
            child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      connection?.dispose();
                      connection=null;
                      sleep(Duration( seconds:1 ,));
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditPresas(
                            server: widget.server,
                              presas: widget.via.presas,
                              index: widget.index,
                              via: widget.via

                          ),
                        ),
                      );
                    } ,

                    //child: Text('Editar'),

                      child: Icon(Icons.edit,)
                  ),//boton de editar
                  SizedBox(width: 40),
                  ElevatedButton(
                    onPressed: () {
                      connection?.dispose();

                      showDialog(
                        context: context,
                        builder: (BuildContext context) => _buildPopupDialog(context),
                      );

                    } ,

                    //child: Text('Eliminar'),
                    child: Icon(Icons.delete,)
                  ),//botón de eliminar
                  SizedBox(width: 40),


                ]
            ),


          ),
        ),
      ],

    );
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        messages.add(
          _Message(
            1,
            backspacesCounter > 0
                ? _messageBuffer.substring(
                0, _messageBuffer.length - backspacesCounter)
                : _messageBuffer + dataString.substring(0, index),
          ),
        );
        _messageBuffer = dataString.substring(index);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
          0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }


  }

  Future _sendMessage(String text) async {
    text = text.trim();
    textEditingController.clear();

    if (text.length > 0) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode(text + "\r\n")));
        await connection!.output.allSent;

        setState(() {
          messages.add(_Message(clientID, text));
        });



      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }


 Future _cargarViaTroncho(List<String> presas) async {

   String troncho = presas.join(",");
   // await _sendMessage("clear");
   // sleep(new Duration(seconds:1));
    await _sendMessage(troncho+", ");
    //sleep(new Duration(seconds:2));
    print(troncho+", ");

  }



  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title:  Text(_nameController.toString()),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Esto hará que esta via se borre para siempre y no podrás volver atrás. Estás de acuerdo?")
        ],
      ),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () {
            box.deleteAt(widget.index);
            Navigator.pushReplacementNamed(context, '/');

          },
         // buttonstyle:(textColor: Theme.of(context).primaryColor),
          child: const Text('Eliminar vía'),
        ),
      ],
    );
  }


}






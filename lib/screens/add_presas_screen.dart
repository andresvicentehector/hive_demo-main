import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:sunboards_vuit/screens/add_via_screen.dart';
import 'package:sunboards_vuit/utils/wall15/wall15.dart';
import 'package:sunboards_vuit/utils/wall25/wall25.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'package:sunboards_vuit/template/ConstantesPropias.dart';

class AddPresas extends StatefulWidget {
  final BluetoothDevice? server;

  const AddPresas({ required this.server});

  @override
  _AddPresas createState() => new _AddPresas();
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _AddPresas extends State<AddPresas> {
  static final clientID = 0;
  BluetoothConnection? connection;
  List<String> presas=[];
  List<_Message> messages = List<_Message>.empty(growable: true);
  String _messageBuffer = '';
  Widget Pared =Container();
  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);

  bool isDisconnecting = false;

  @override
  void initState() {
    super.initState();

    BluetoothConnection.toAddress(widget.server!.address).then((_connection) {
      print('Connected to the device');

       connection = _connection;
      _sendMessage("clear");
        setState(() {
        isConnecting = false;
        isDisconnecting = false;


      });



      connection!.input!.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
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

  @override
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

   if(version=="25"){Pared=Wall25(sendMessage: _sendMessage, presas: presas);}else {Pared = Wall15(sendMessage: _sendMessage, presas: presas);
    }
    final serverName = widget.server!.name ?? "Unknown";
    return Scaffold(
      appBar: AppBar(
          title: (isConnecting
              ? Text('Conectando con ' + serverName + '...')
              : isConnected
                  ? Text('Elige las presas')
                  : Text('Envía presas a ' + serverName)),

          actions: <Widget>[
      ElevatedButton(
      child: Icon(Icons.save_rounded, color: Colors.greenAccent ,semanticLabel: "Guardar",  ),
      onPressed: ()  {

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              connection?.dispose();
              return AddScreen( presas: presas,);
            },
          ),
        );


      },
    ),
    ],
      ),
      body: Container(

        child:

            Stack(
              children:[
                Container(
                  width:1332 ,
                  height: 800,
                  decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(fondo)) ),
                ),
                Zoom(

                initTotalZoomOut: true,
                doubleTapZoom: false,
                child: SizedBox(
                  width: 936,
                  height: 624,
                  child: Stack(
                    children: <Widget>[
                      Container(color: Colors.grey),
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(pared_trans),

                            )),),
                      Pared,

                    ],
                  ),
                ),
              ),]
            ),
            //boton de editar


    )
    );}

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

  void _sendMessage(String text) async {
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
}

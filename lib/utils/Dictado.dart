import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:sunboards_vuit/utils/wall15/wall15_dictado.dart';
import 'package:sunboards_vuit/utils/wall25/wall25_dictado.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'package:sunboards_vuit/template/ConstantesPropias.dart';

class Dictado extends StatefulWidget {
  final BluetoothDevice server;

  const Dictado({required this.server});

  @override
  _Dictado createState() => new _Dictado();
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _Dictado extends State<Dictado> {
  static final clientID = 0;
  BluetoothConnection? connection;
  int _colorController= Colors.green.value;
  Widget Pared = Container();

  List<_Message> messages = List<_Message>.empty(growable: true);
  String _messageBuffer = '';

  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);

  bool isDisconnecting = false;

  @override
  void initState() {
    super.initState();

    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
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
          setState(() {


          });
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

    if(version=="25"){
      Pared=  Wall25Dictado(sendMessage: _sendMessage);

    }else{
     Pared= Wall15Dictado(sendMessage: _sendMessage);

    }


    final serverName = widget.server.name ?? "Unknown";
    return Scaffold(
      appBar: AppBar(
          title: (isConnecting
              ? Text('Conectando con ' + serverName + '...')
              : isConnected
                  ? Text('Modo dictado')
                  : Text('Envía presas a ' + serverName)),
        leading: Container(

          child: ElevatedButton(
          child:  Icon(Icons.arrow_back ,color: Colors.white,),
          onPressed: ()  {
            connection?.dispose();
            connection=null;
            Navigator.pushReplacementNamed(context, '/');

          },
        ),),
      actions: <Widget>[
        ElevatedButton(
          child: Icon(Icons.clean_hands_rounded, color: Colors.white ,semanticLabel: "Guardar",  ),
          onPressed: ()  {
            _sendMessage("clear");

          },
        ),
      ],),

      body: SafeArea(
        child:
        Zoom(
          initTotalZoomOut: true,
          doubleTapZoom: false,
          child: Center(
            child: SizedBox(

              width: 956,
              height: 624,
              child: Stack(


                children: <Widget>[

              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(fondo),
                      fit: BoxFit.fill,
                    )
                )
              ),
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
          ),
        ),
      ),
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

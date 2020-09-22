import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus{
  Online,
  Offline,
  Connecting
}

class SocketService with ChangeNotifier{

  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;

  SocketService(){
    this._initConfig();
  }

  void _initConfig(){
    this._socket = IO.io('http://192.168.1.69:3000', {
      'transports': ['websocket'],
      'extraHeaders': {'foo': 'bar'},
      'autoConnect': true
    });

    this._socket.on('connect', (_) {
      print('connect');
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.on('disconnect', (_) {
      print('disconnect');
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    // socket.on('nuevo-mensaje', (payload){
    //   print('nuevo-mensaje:');
    //   print('Nombre:' + payload['nombre']);
    //   print('Mensaje:' + payload['mensaje']);
    //   print(payload.containsKey('mensaje2') ? payload['mensaje2'] : 'No hay');
    // });



  }
}
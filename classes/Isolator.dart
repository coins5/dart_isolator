import 'dart:io';
import 'dart:async';
import 'dart:isolate';

import './DumbClass.dart';

class Isolator {
  List<IsolatorStructure> isolates = new List<IsolatorStructure>();
  
  void createIsolates() {
    for (int i = 0; i < 200; i++) {
      isolates.add(new IsolatorStructure(identifier: 'I${i}', onSpawn: runTimer));
    }
  }
  void spawnIsolates() {
    isolates.forEach((i) => i.spawnIsolate());
  }
}

class IsolatorStructure {
    String identifier;
    Isolate isolate;
    ReceivePort port;
    var onSpawn;

    IsolatorStructure({
        this.identifier,
        this.onSpawn
    });

  void spawnIsolate () async {
    this.port = ReceivePort();
    this.isolate = await Isolate.spawn(this.onSpawn, this.port.sendPort);
    final String message = 'RECEIVE FROM ${this.identifier}: ';
    this.port.listen((data) {
      stdout.writeln(message + data + ', ');
    });
  }
}

void runTimer(SendPort sendPort) {
  new DumbClass().runTimer(sendPort);
  /*
    int counter = 0;
    Timer.periodic(new Duration(seconds: 1), (Timer t) {
      counter++;
      String msg = 'notification ' + counter.toString();  
      stdout.write('SEND: ' + msg + ' - ');  
      sendPort.send(msg);
    });
  */
}
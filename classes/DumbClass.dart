import 'dart:io';
import 'dart:async';
import 'dart:isolate';

class DumbClass {
  void runTimer(SendPort sendPort) {
    int counter = 0;
    stdout.write('FROM DUMBCLASS');
    Timer.periodic(new Duration(seconds: 1), (Timer t) {
      counter++;
      String msg = 'notification ' + counter.toString();  
      stdout.write('SEND: ' + msg + ' - ');  
      sendPort.send(msg);
    });
  }
}
import 'dart:io';
import 'dart:async';
import 'dart:isolate';

// Isolate isolate;
// Isolate isolate2;

List<Isolate> isolates = new List<Isolate>();
List<ReceivePort> ports = new List<ReceivePort>();

void start() async {
  /*
  spawnIsolate(1);
  spawnIsolate(2);
  spawnIsolate(3);
  */
  for (int i = 0; i < 1000; i++) {
    spawnIsolate(i);
  }
}

void spawnIsolate (int identifier) async {
  ReceivePort receivePort = ReceivePort();
  ports.add(receivePort);
  isolates.add(await Isolate.spawn(runTimer, receivePort.sendPort));
  final String message = 'RECEIVE FROM ${identifier}: ';

  receivePort.listen((data) {
    stdout.writeln(message + data + ', ');
  });
}

void runTimer(SendPort sendPort) {
  int counter = 0;
  Timer.periodic(new Duration(seconds: 1), (Timer t) {
    counter++;
    String msg = 'notification ' + counter.toString();  
    stdout.write('SEND: ' + msg + ' - ');  
    sendPort.send(msg);
  });
}
/*
void stop() {  
  if (isolate != null) {
      stdout.writeln('killing isolate');
      isolate.kill(priority: Isolate.immediate);
      isolate = null;        
  }
}
*/

void stop() {  
  if (isolates[0] != null) {
      stdout.writeln('killing isolate');
      isolates[0].kill(priority: Isolate.immediate);
      isolates[0] = null;        
  }
}

void main() async {
  stdout.writeln('spawning isolate...');
  await start();
  stdout.writeln('press enter key to quit...');
  await stdin.first;
  stop();
  stdout.writeln('goodbye!');
  exit(0);
}
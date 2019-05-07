import 'dart:io';
import 'dart:async';

import 'classes/Isolator.dart';

void start() async {
  Isolator isolator = new Isolator();
  isolator.createIsolates();
  isolator.spawnIsolates();
}

void main() async {
  stdout.writeln('spawning isolate...');
  await start();
  stdout.writeln('press enter key to quit...');
  await stdin.first;
  // stop();
  stdout.writeln('goodbye!');
  exit(0);
}
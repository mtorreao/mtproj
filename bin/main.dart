import 'dart:io';
import 'package:args/args.dart';
import 'package:mtproj/mtproj.dart' as mtproj;

main(List<String> arguments) {
  exitCode = 0;
  final parser = ArgParser();
  // ..addOption('zip', abbr: 'z')
  // ..addOption('country', abbr: 'c', defaultsTo: 'de');

  final argResults = parser.parse(arguments);

  stderr.writeln('success');

  // weatherCli(argResults['zip'], argResults['country']);
}

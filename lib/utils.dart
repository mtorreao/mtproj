import 'dart:io';
import 'package:yaml/yaml.dart';

Future<String> getVersion() async {
  File file =
      File(File.fromUri(Platform.script).parent.parent.path + "/pubspec.lock");
  var doc = loadYaml(file.readAsStringSync());
  return doc['packages']['mtproj']['version'].toString();
}

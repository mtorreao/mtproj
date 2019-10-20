import 'package:args/command_runner.dart';
import 'package:mtproj/modules/create.dart';

import 'command_base.dart';

class CreateCommand extends CommandBase {
  final name = "create";
  final description = "Create a Flutter project with basic structure";
  final invocationSufix = "<project name>";

  CreateCommand() {
    argParser.addOption('description',
        abbr: 'd',
        help:
            "The description to use for your new Flutter project. This string ends up in the pubspec.yaml file. (defaults to \"A new Flutter project. Created by Slidy\")");

    argParser.addOption('org',
        abbr: 'o',
        help:
            "The organization responsible for your new Flutter project, in reverse domain name notation. This string is used in Java package names and as prefix in the iOS bundle identifier. (defaults to \"com.example\")");
  }

  void run() {
    if (argResults.rest.isEmpty) {
      throw UsageException(
          "project name not passed for a create command", usage);
    } else {
      create(argResults.rest.first, argResults['description'], argResults['org']);
    }
  }
}

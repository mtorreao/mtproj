import 'package:args/command_runner.dart';
import 'package:mtproj/commands/command_base.dart';
import 'package:mtproj/modules/git.dart';

class GitCommand extends CommandBase {
  final name = "git";
  final description =
      "Help create the a git repository and can do the initial commit and create a github repo";
  final invocationSufix = "<repository name>";

  GitCommand() {
    argParser.addOption('host',
        abbr: 'o',
        help:
            "The host provider of you code, can be 'github'. Default is 'github'. ");
    argParser.addOption('username',
        abbr: 'u',
        help:
            "The username to be used in remote repository. Without this, remote repo can't be acessed.");
  }

  void run() {
    if (argResults.rest.isEmpty) {
      throw UsageException(
          "$invocationSufix not passed for a $name command", usage);
    } else {
      git(argResults.rest.first,
          host: argResults['host'] == null ? 'github' : null,
          username: argResults['username']);
    }
  }
}

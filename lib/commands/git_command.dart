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

    argParser.addFlag('private',
        abbr: 'p',
        defaultsTo: false,
        help: 'Send this flag to create repo as private. Default is public.');

    argParser.addOption('github-token',
        abbr: 'g',
        help:
            'GitHub OAuth 2.0 token for github repositories, this is required for this command meanwhile the config command is not ready yet.');
  }

  void run() {
    if (argResults.rest.isEmpty) {
      throw UsageException(
          "$invocationSufix not passed for a $name command", usage);
    } else if (argResults['github-token'] == null) {
      throw UsageException("github-token not passed for the command", usage);
    } else if (argResults['username'] == null) {
      throw UsageException("username not passed for the command", usage);
    } else {
      final git = GitCommands(argResults.rest.first,
          host: argResults['host'] == null ? 'github' : null,
          username: argResults['username'],
          private: argResults['private'],
          token: argResults['github-token']);
      git.run();
    }
  }
}

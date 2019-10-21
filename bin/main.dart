import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:mtproj/commands/create_command.dart';
import 'package:mtproj/commands/git_command.dart';
import 'package:mtproj/version.dart';

main(List<String> arguments) {
  CommandRunner runner = configureCommand(arguments);

  bool hasCommand = runner.commands.keys.any((x) => arguments.contains(x));

  if (hasCommand) {
    executeCommand(runner, arguments);
  } else {
    ArgParser parser = ArgParser();
    parser = runner.argParser;
    var results = parser.parse(arguments);
    executeOptions(results, arguments, runner);
  }
}

void executeOptions(
    ArgResults results, List<String> arguments, CommandRunner runner) {
  if (results.wasParsed("help") || arguments.isEmpty) {
    print(runner.usage);
  }

  if (results.wasParsed("version")) {
    version();
  }
}

void executeCommand(CommandRunner runner, List<String> arguments) {
  runner.run(arguments).catchError((error) {
    if (error is! UsageException) throw error;
    print(error);
  });
}

CommandRunner configureCommand(List<String> arguments) {
  var runner =
      CommandRunner("mtproj", "CLI command tools for my personal projects")
        ..addCommand(CreateCommand())
        ..addCommand(GitCommand());

  runner.argParser.addFlag("version", abbr: "v", negatable: false);
  return runner;
}

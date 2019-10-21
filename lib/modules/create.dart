import 'dart:io';

Future create(String projectName, String description, String org) async {
  final process = await Process.start(
      'flutter', ['create', ...getArgumentList(projectName, description, org)],
      runInShell: true);

  await stdout.addStream(process.stdout);
  await stderr.addStream(process.stderr);
  final exitcode = await process.exitCode;
  print('Exitcode: $exitCode');
  if (exitcode == 0) {
    final processSlidy = await Process.start('slidy', ['start', '-f', '-c'],
        runInShell: true, workingDirectory: './$projectName');
    await stdout.addStream(processSlidy.stdout);
    await stderr.addStream(processSlidy.stderr);
    final exitCodeSlidy = await processSlidy.exitCode;
    print('Exitcode: $exitCodeSlidy');
    if (exitCodeSlidy == 0) {
      final processGit = await Process.start('git', ['init'],
          runInShell: true, workingDirectory: './$projectName');
      await stdout.addStream(processGit.stdout);
      await stderr.addStream(processGit.stderr);
      final exitCodeGitInit = await processGit.exitCode;
      print('Exitcode: $exitCodeGitInit');
      if (exitCodeGitInit == 0) {
        stdout.writeln('Success');
      }
    }
  }
}

List<String> getArgumentList(
    String projectName, String description, String org) {
  List<String> list = [];

  if (description != null && description.isNotEmpty) {
    list..add('-d')..add(description);
  }
  if (org != null && org.isNotEmpty) {
    list..add('-o')..add(org);
  }
  list.add(projectName);
  return list;
}

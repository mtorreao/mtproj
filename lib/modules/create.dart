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
      stdout.writeln('Success');
    }
  }
}

List<String> getArgumentList(
    String projectName, String description, String org) {
  List<String> list = [];

  if (description != null && description.isNotEmpty) {
    list..add('--description')..add(description);
  }
  if (org != null && org.isNotEmpty) {
    list..add('--org')..add(org);
  }
  list.add('--no-pub');
  list.add('--androidx');
  list.add(projectName);
  return list;
}

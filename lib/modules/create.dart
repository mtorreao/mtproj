import 'dart:io';

void create(String projectName, String description, String org) {
  Process.start('flutter',
          ['create', ...getArgumentList(projectName, description, org)],
          runInShell: true)
      .then((process) {
    stdout.addStream(process.stdout);
    stderr.addStream(process.stderr);
    process.exitCode.then((exitcode) {
      print('Exitcode: $exitCode');
    });
  });
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

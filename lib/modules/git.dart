import 'dart:io';

import 'package:dotenv/dotenv.dart' show load, env;
import 'package:mtproj/models/base_model.dart';
import 'package:mtproj/services/base_api.dart';
import 'package:mtproj/services/github_api.dart';

git(String repoName,
    {String host, String username, bool private = false}) async {
  final hasUsername = username != null && username.isNotEmpty;
  final hasHost = host != null && host.isNotEmpty;
  load();
  if (await gitInit(repoName) == 0) {
    if (await gitAddAll(repoName) == 0) {
      // if (await gitCommit('Initial commit', repoName) == 0) {
      if (hasHost &&
          hasUsername &&
          await gitCreateRemoteRepo(repoName, host, username) == 0) {
        stdout.writeln('Success');
      }
      // }
    }
  }
}

Future<int> gitInit(String repoName) async {
  final process = await Process.start('git', ['init'],
      runInShell: true, workingDirectory: './$repoName');
  addStreamsToStd(process);
  final exitCode = await process.exitCode;
  print('Git Init exit code: $exitCode');
  return exitCode;
}

Future<int> gitAddAll(String repoName) async {
  final process = await Process.start('git', ['add', '.'],
      runInShell: true, workingDirectory: './$repoName');
  addStreamsToStd(process);
  final exitCode = await process.exitCode;
  print('Git Add All exit code: $exitCode');
  return exitCode;
}

Future<int> gitCommit(String commitMessage, String repoName) async {
  assert(commitMessage != null && commitMessage.isNotEmpty);
  final process = await Process.start('git', ['commit', '-m', commitMessage],
      runInShell: true, workingDirectory: './$repoName');
  addStreamsToStd(process);
  final exitCode = await process.exitCode;
  print('Git Commit exit code: $exitCode');
  return exitCode;
}

Future<int> gitCreateRemoteRepo(
    String repoName, String hostName, String username) async {
  assert(repoName != null && repoName.isNotEmpty);
  BaseApi api;
  BaseModel createdRepo;
  if (hostName == 'github') {
    final api2 = GitHubApiService(username, env['github_token']);
    createdRepo = await api2.createRepo(repoName);
  }

  if (createdRepo == null) return 2;
  return createdRepo.hasErrors ? 0 : 1;
}

addStreamsToStd(Process process) async {
  await stdout.addStream(process.stdout);
  await stderr.addStream(process.stderr);
}

import 'dart:io';

import 'package:mtproj/services/github_api.dart';

class GitCommands {
  String repoName;
  String cloneUrl;
  String username;
  String host;
  bool private;
  String token;

  GitCommands(this.repoName,
      {this.host, this.username, this.private = false, this.token}) {}

  Future<bool> run() async {
    final hasUsername = username != null && username.isNotEmpty;
    final hasHost = host != null && host.isNotEmpty;
    try {
      if (await gitInit(repoName) == 0) {
        if (await gitAddAll(repoName) == 0) {
          if (await gitCommit('Initial commit', repoName)) {
            if (hasHost && hasUsername && await gitCreateRemoteRepo()) {
              if (await gitRemoteAdd() == 0) {
                if (await gitPush(upstream: true) == 0) {
                  stdout.writeln('Success');
                  return true;
                }
              }
            }
          }
        }
      }
    } on Error catch (e) {
      print(e.toString());
    }
    return false;
  }

  Future<int> gitInit(String repoName) async {
    final process = await Process.start(
      'git',
      ['init'],
      runInShell: true,
    );
    addStreamsToStd(process);
    final exitCode = await process.exitCode;
    print('Git Init exit code: $exitCode');
    return exitCode;
  }

  Future<int> gitAddAll(String repoName) async {
    final process = await Process.start(
      'git',
      ['add', '.'],
      runInShell: true,
    );
    addStreamsToStd(process);
    final exitCode = await process.exitCode;
    print('Git Add All exit code: $exitCode');
    return exitCode;
  }

  Future<bool> gitCommit(String commitMessage, String repoName) async {
    assert(commitMessage != null && commitMessage.isNotEmpty);
    final process = await Process.start(
      'git',
      ['commit', '-m', commitMessage],
      runInShell: true,
    );
    addStreamsToStd(process);
    final exitCode = await process.exitCode;
    print('Git Commit exit code: $exitCode');
    return exitCode == 0 || exitCode == 1;
  }

  Future<bool> gitCreateRemoteRepo() async {
    assert(repoName != null && repoName.isNotEmpty);
    bool isCreated = false;
    try {
      if (this.host == 'github') {
        final service = GitHubApiService(username, this.token);
        final response =
            await service.createRepo(repoName, private: this.private);
        this.cloneUrl = response.url;
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }

    return isCreated;
  }

  addStreamsToStd(Process process) async {
    await stdout.addStream(process.stdout);
    await stderr.addStream(process.stderr);
  }

  Future<int> gitRemoteAdd() async {
    assert(cloneUrl != null && cloneUrl.isNotEmpty);
    final process = await Process.start(
      'git',
      ['remote', 'add', 'origin', this.cloneUrl + '.git'],
      runInShell: true,
    );
    addStreamsToStd(process);
    final exitCode = await process.exitCode;
    print('Git Remote Add exit code: $exitCode');
    return exitCode;
  }

  Future<int> gitPush(
      {upstream = false, remote = 'origin', brach = 'master'}) async {
    var subcommands = ['push'];
    if (upstream) subcommands.add('-u');
    subcommands.add(remote);
    subcommands.add(brach);
    final process = await Process.start(
      'git',
      subcommands,
      runInShell: true,
    );
    addStreamsToStd(process);
    final exitCode = await process.exitCode;
    print('Git Push exit code: $exitCode');
    return exitCode;
  }
}

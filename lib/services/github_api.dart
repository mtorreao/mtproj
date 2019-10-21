import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:mtproj/services/base_api.dart';

class GitHubApi extends BaseApi {
  final baseUrl = 'https://api.github.com';

  final String username;
  final String oauthToken;

  GitHubApi(this.username, this.oauthToken) {
    assert(this.username != null && this.username.isNotEmpty);
    assert(this.oauthToken != null && this.oauthToken.isNotEmpty);
  }

  getUser() async {
    final url = '${baseUrl}/users/$username';
    print(url);
    final response = await http.get(url);
    print(response.body);
  }

  checkUserScopes() async {
    final url = '${baseUrl}/users/$username';
    final response = await http.get(url, headers: {
      ...getAuthorization(),
    });
    print(response.headers);
    print(response.body);
    print(response.request);
    print(response.statusCode);
  }

  getUserRepos() async {
    final url = '${baseUrl}/users/$username/repos';
    final response = await http.get(url, headers: {
      ...getAuthorization(),
    });
    print(response.headers);
    print(response.body);
    print(response.request);
    print(response.statusCode);
  }

  Future<bool> createRepo(String repositoryName, {bool private = false}) async {
    final url = '${baseUrl}/user/repos';
    try {
      final response = await Dio()
          .post(url, options: Options(headers: {...getAuthorization()}), data: {
        'name': repositoryName,
        // 'auto_init': 'false',
        'private': private.toString(),
        // 'gitignore_template': 'nanoc'
      });
      print(jsonEncode(response.data));
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Map<String, String> getAuthorization() {
    return {'Authorization': 'token $oauthToken'};
  }
}

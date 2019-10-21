import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class GitHubApi {
  final baseUrl = 'https://api.github.com';

  final String username;
  final String oauthToken;

  GitHubApi(this.username, this.oauthToken);

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

  createARepository(String repositoryName) async {
    final url = '${baseUrl}/user/repos';
    try {
      final response = await Dio()
          .post(url, options: Options(headers: {...getAuthorization()}), data: {
        'name': repositoryName,
        // 'auto_init': 'false',
        // 'private': "false",
        // 'gitignore_template': 'nanoc'
      });
      print(response.data);
    } catch (e) {
      print(e);
    }
  }

  Map<String, String> getAuthorization() {
    return {'Authorization': 'token $oauthToken'};
  }
}

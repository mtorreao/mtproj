import 'package:graphql/client.dart';
import 'package:mtproj/models/github_create_repo_response.dart';

class GitHubApiService {
  final HttpLink _httpLink = HttpLink(
    uri: 'https://api.github.com/graphql',
  );
  AuthLink _authLink;
  Link _link;
  GraphQLClient _client;

  final String oauthtoken;
  final String username;

  GitHubApiService(this.username, this.oauthtoken) {
    assert(this.username != null && this.username.isNotEmpty);
    assert(this.oauthtoken != null && this.oauthtoken.isNotEmpty);
    _authLink = AuthLink(
      getToken: () async => 'token ${this.oauthtoken}',
    );
    _link = _authLink.concat(_httpLink);
    _client = GraphQLClient(
      cache: InMemoryCache(),
      link: _link,
    );
  }

  @override
  Future<GitHubCreateRepoResponse> createRepo(String repositoryName,
      {bool private = false}) async {
    const String createRepo = r'''
        mutation AddRepo($input: CreateRepositoryInput!) {
          createRepository(input: $input) {
            clientMutationId,
            repository {
              createdAt,
              url,
              isPrivate,
            }
          }
        }
      ''';

    final MutationOptions options = MutationOptions(
      document: createRepo,
      variables: <String, dynamic>{
        "input": {
          "name": "test_project",
          "visibility": private ? "PRIVATE" : "PUBLIC",
        },
      },
    );

    try {
      final QueryResult result = await _client.mutate(options);

      if (result.hasErrors) {
        print(result.errors);
      }

      return GitHubCreateRepoResponse.fromJson(result.data);
    } on CastError catch (e) {
      print(e);
    }
    return null;
  }
}

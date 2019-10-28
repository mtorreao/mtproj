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

  Future<GitHubResponse> createRepo(String repositoryName,
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
          "name": repositoryName,
          "visibility": private ? "PRIVATE" : "PUBLIC",
        },
      },
    );

    try {
      final QueryResult result = await _client.mutate(options);

      if (result.hasErrors) {
        if (result.errors.singleWhere((error) =>
                error.message.toLowerCase() ==
                'Name already exists on this account'.toLowerCase()) !=
            null) {
          return await getRepoInfo(repositoryName);
        }
      }

      return GitHubResponse.fromJson(result.data['createRepository']['repository']);
    } on CastError catch (e) {
      print(e);
    }
    return null;
  }

  Future<GitHubResponse> getRepoInfo(String repoName) async {
    const String getRepoInfo = r'''
        query getRepoInfo($owner: String!, $name: String!) {
          repository(owner: $owner, name: $name) {
            url,
            isPrivate,
            createdAt
          }
        }
      ''';

    final options = QueryOptions(
      document: getRepoInfo,
      variables: <String, dynamic>{"owner": this.username, "name": repoName},
    );

    try {
      final QueryResult result = await _client.query(options);

      if (result.hasErrors) {
        print(result.errors);
      }

      return GitHubResponse.fromJson(result.data['repository']);
    } catch (e) {
      print(e);
    }
    return null;
  }
}

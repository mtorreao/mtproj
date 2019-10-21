abstract class BaseApi {
  Future<bool> createRepo(String repositoryName, {bool private = false});
}
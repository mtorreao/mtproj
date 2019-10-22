import 'package:mtproj/models/base_model.dart';

class GitHubCreateRepoResponse extends BaseModel {
  CreateRepository createRepository;

  GitHubCreateRepoResponse({
    this.createRepository,
  });

  factory GitHubCreateRepoResponse.fromJson(Map<String, dynamic> json) =>
      GitHubCreateRepoResponse(
        createRepository: json["createRepository"] == null
            ? null
            : CreateRepository.fromJson(json["createRepository"]),
      );

  Map<String, dynamic> toJson() => {
        "createRepository":
            createRepository == null ? null : createRepository.toJson(),
      };
}

class CreateRepository {
  dynamic clientMutationId;
  Repository repository;

  CreateRepository({
    this.clientMutationId,
    this.repository,
  });

  factory CreateRepository.fromJson(Map<String, dynamic> json) =>
      CreateRepository(
        clientMutationId: json["clientMutationId"],
        repository: json["repository"] == null
            ? null
            : Repository.fromJson(json["repository"]),
      );

  Map<String, dynamic> toJson() => {
        "clientMutationId": clientMutationId,
        "repository": repository == null ? null : repository.toJson(),
      };
}

class Repository {
  DateTime createdAt;
  String url;
  bool isPrivate;

  Repository({
    this.createdAt,
    this.url,
    this.isPrivate,
  });

  factory Repository.fromJson(Map<String, dynamic> json) => Repository(
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        url: json["url"] == null ? null : json["url"],
        isPrivate: json["isPrivate"] == null ? null : json["isPrivate"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "url": url == null ? null : url,
        "isPrivate": isPrivate == null ? null : isPrivate,
      };
}

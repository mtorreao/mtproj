import 'package:mtproj/models/base_model.dart';

class GitHubResponse extends BaseModel {
  DateTime createdAt;
  String url;
  bool isPrivate;

  GitHubResponse({
    this.createdAt,
    this.url,
    this.isPrivate,
  });

  factory GitHubResponse.fromJson(Map<String, dynamic> json) =>
      GitHubResponse(
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

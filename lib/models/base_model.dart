import 'package:graphql/client.dart';

class BaseModel {
  List<GraphQLError> errors;
  String cloneUrl;

  bool get hasErrors => errors != null && errors.isNotEmpty;
}

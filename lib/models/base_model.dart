import 'package:graphql/client.dart';

class BaseModel {
  List<GraphQLError> errors;

  bool get hasErrors => errors != null && errors.isNotEmpty;
}

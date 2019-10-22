import 'package:mtproj/models/base_model.dart';

abstract class BaseApi {
  Future<T> createRepo<T extends BaseModel>(String repositoryName, {bool private = false});
}
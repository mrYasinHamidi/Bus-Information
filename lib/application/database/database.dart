import 'package:new_bus_information/application/models/base_object.dart';
import 'package:new_bus_information/application/models/base_object_type.dart';

abstract class Database {

  List<BaseObject> get(BaseObjectType type);

  void put(BaseObject object);

  void delete(BaseObject object);

  bool contain(BaseObject object);
}

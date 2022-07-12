import 'package:flutter/foundation.dart';
import 'package:new_bus_information/application/database/database_event.dart';
import 'package:new_bus_information/application/models/base_object.dart';
import 'package:new_bus_information/application/models/base_object_type.dart';

abstract class Database {
  void put(BaseObject object);

  Future<void> delete(BaseObject object);

  bool containName(String name);

  bool containBusCode(String busCode);

  BaseObject? getObject(String id, BaseObjectType type);

  List<BaseObject> getObjects(BaseObjectType type);

  Stream<DatabaseEvent> listen();
}

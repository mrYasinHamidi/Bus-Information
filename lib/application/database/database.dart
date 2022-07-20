import 'package:flutter/material.dart';
import 'package:new_bus_information/application/database/database_event.dart';
import 'package:new_bus_information/application/models/base/base_object.dart';
import 'package:new_bus_information/application/models/base/base_object_type.dart';
import 'package:new_bus_information/application/models/new_models.dart';

abstract class Database {
  void put(BaseObject object);

  Future<void> delete(BaseObject object);

  bool containName(String name);

  bool containBusCode(String busCode);

  BaseObject? getObject(String id, BaseObjectType type);

  List<BaseObject> getObjects(BaseObjectType type);

  Stream<DatabaseEvent> listen();
}

abstract class NewDatabase {
  void putBus(NewBus bus);
  void putDriver(NewDriver driver);
  void putProp(NewProp prop);

  void deleteBus(NewBus bus);
  void deleteDriver(NewDriver driver);
  void deleteProp(NewProp prop);

  bool containtBus(NewBus bus);
  bool containtDriver(NewDriver driver);
  bool containtProp(NewProp prop);

  Iterable<NewBus> getBuses();
  Iterable<NewDriver> getDrivers();
  Iterable<NewProp> getProps();

  ValueNotifier<NewDatabaseEventType> listen();
}

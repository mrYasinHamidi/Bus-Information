import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:new_bus_information/application/extensions.dart';
import 'package:new_bus_information/application/models/base_object.dart';
import 'package:new_bus_information/application/models/base_object_type.dart';
import 'package:new_bus_information/application/models/bus/bus.dart';
import 'package:new_bus_information/application/models/driver/driver.dart';
import 'package:new_bus_information/application/models/prop/prop.dart';
import 'package:objectid/objectid.dart';

import 'database.dart';

class NoSqlDatabase implements Database {
  static const String driverBoxKey = 'driverBoxKey1';
  static const String busBoxKey = 'busBoxKey1';
  static const String propBoxKey = 'propBoxKey1';

  final Box _busBox = Hive.box(busBoxKey);
  final Box _driverBox = Hive.box(driverBoxKey);
  final Box _propBox = Hive.box(propBoxKey);

  static Future<void> open() => Future.wait([
        Hive.openBox(driverBoxKey),
        Hive.openBox(busBoxKey),
        Hive.openBox(propBoxKey),
      ]);

  BaseObject _object(BaseObjectType type, String json) {
    switch (type) {
      case BaseObjectType.driver:
        return Driver.fromJson(json);
      case BaseObjectType.bus:
        return Bus.fromJson(json);
      case BaseObjectType.prop:
        return Prop.fromJson(json);
    }
  }

  Box _box(BaseObjectType type) {
    switch (type) {
      case BaseObjectType.driver:
        return _driverBox;
      case BaseObjectType.bus:
        return _busBox;
      case BaseObjectType.prop:
        return _propBox;
        break;
    }
  }

  @override
  void put(BaseObject object) => _box(object.type).put(object.key, object.toJson());

  @override
  void delete(BaseObject object) => _box(object.type).delete(object.key);

  @override
  bool containName(String name) =>
      getObjects(BaseObjectType.driver).indexWhere((element) => (element as Driver).name == name) != -1;

  @override
  bool containBusCode(String busCode) =>
      getObjects(BaseObjectType.bus).indexWhere((element) => (element as Bus).busCode == busCode) != -1;

  @override
  BaseObject getObject(String id, BaseObjectType type) => _box(type).get(id);

  @override
  List<BaseObject> getObjects(BaseObjectType type) => _box(type).values.map((e) => _object(type, e)).toList()..reSort();

  @override
  ValueListenable listen(BaseObjectType type) {
    return _box(type).listenable();
  }
}

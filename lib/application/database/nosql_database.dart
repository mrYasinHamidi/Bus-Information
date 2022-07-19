import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:new_bus_information/application/database/database_event.dart';
import 'package:new_bus_information/application/extensions.dart';
import 'package:new_bus_information/application/models/base_object.dart';
import 'package:new_bus_information/application/models/base_object_type.dart';
import 'package:new_bus_information/application/models/bus/bus.dart';
import 'package:new_bus_information/application/models/driver/driver.dart';
import 'package:new_bus_information/application/models/prop/prop.dart';
import 'package:objectid/objectid.dart';

import 'database.dart';

class NoSqlDatabase implements Database {
  static const String driverBoxKey = 'driverBoxKey3';
  static const String busBoxKey = 'busBoxKey3';
  static const String propBoxKey = 'propBoxKey3';

  final StreamController<DatabaseEvent> _controller = StreamController();

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
    }
  }

  @override
  void put(BaseObject object) {
    _box(object.type).put(object.key, object.toJson());
    _controller.add(DatabaseEvent(object: object, eventType: DatabaseEventType.put));
  }

  @override
  Future<void> delete(BaseObject object) async {
    _box(object.type).delete(object.key);
    _controller.add(DatabaseEvent(object: object, eventType: DatabaseEventType.delete));
  }

  @override
  bool containName(String name) =>
      getObjects(BaseObjectType.driver).indexWhere((element) => (element as Driver).name == name) != -1;

  @override
  bool containBusCode(String busCode) =>
      getObjects(BaseObjectType.bus).indexWhere((element) => (element as Bus).busCode == busCode) != -1;

  @override
  BaseObject? getObject(String id, BaseObjectType type) {
    BaseObject? object;
    String data = _box(type).get(id) ?? '';
    if (data.isNotEmpty) object = _object(type, data);
    return object;
  }

  @override
  List<BaseObject> getObjects(BaseObjectType type) {
    List<BaseObject> objects = <BaseObject>[];
    Iterable data = _box(type).values;
    if (data.isNotEmpty) {
      objects = data.map((e) => _object(type, e)).toList();
      objects.reSort();
      if (type == BaseObjectType.prop) {
        for (Prop prop in objects.cast<Prop>()) {
          if (prop.busId != null) {
            prop.bus = getObject(prop.busId!, BaseObjectType.bus) as Bus;
          }
          if (prop.driverId != null) {
            prop.firstDriver = getObject(prop.driverId!, BaseObjectType.driver) as Driver;
          }
          if (prop.secondDriverId != null) {
            prop.secondDriver = getObject(prop.secondDriverId!, BaseObjectType.driver) as Driver;
          }
        }
      }
    }
    return objects;
  }

  @override
  Stream<DatabaseEvent> listen() => _controller.stream;
}

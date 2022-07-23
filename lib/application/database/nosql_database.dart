import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_bus_information/application/database/database_event.dart';
import 'package:new_bus_information/application/models/base/base_object.dart';
import 'package:new_bus_information/application/models/base/base_object_extension.dart';
import 'package:new_bus_information/application/models/base/base_object_type.dart';
import 'package:new_bus_information/application/models/bus/bus.dart';
import 'package:new_bus_information/application/models/driver/driver.dart';
import 'package:new_bus_information/application/models/new_bus.dart';
import 'package:new_bus_information/application/models/new_driver.dart';
import 'package:new_bus_information/application/models/new_prop.dart';
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
      objects = data.map((e) {
        BaseObject object = _object(type, e);
        if (object is Prop) {
          object.addInstances(this);
        }
        return object;
      }).toList();

      objects.reSort();
    }
    return objects;
  }

  @override
  Stream<DatabaseEvent> listen() => _controller.stream;
}

class NewHiveDatabase implements NewDatabase {
  NewHiveDatabase(
    this.buses,
    this.drivers,
    this.props,
  );

  final Box<NewProp> props;
  final Box<NewDriver> drivers;
  final Box<NewBus> buses;

  final StreamController<NewDatabaseEvent> _notifier = StreamController();

  @override
  bool containtBus(NewBus bus) {
    _requireInitialized();
    return buses.values
        .firstWhere(
          (element) => element == bus,
          orElse: () => NewBus(),
        )
        .isEmpty();
  }

  @override
  bool containtDriver(NewDriver driver) {
    _requireInitialized();
    return drivers.values
        .firstWhere(
          (element) => element == driver,
          orElse: () => NewDriver(),
        )
        .isEmpty();
  }

  @override
  bool containtProp(NewProp prop) {
    _requireInitialized();
    return props.values
        .firstWhere(
          (element) => element == prop,
          orElse: () => NewProp(),
        )
        .isEmpty();
  }

  @override
  void deleteBus(NewBus bus) async {
    _requireInitialized();
    await buses.delete(bus.id);
    _notifier.add(NewDatabaseEvent(NewDatabaseEventType.bus));
  }

  @override
  void deleteDriver(NewDriver driver) async {
    _requireInitialized();
    await drivers.delete(driver.id);
    _notifier.add(NewDatabaseEvent(NewDatabaseEventType.driver));
  }

  @override
  void deleteProp(NewProp prop) async {
    _requireInitialized();
    await props.delete(prop.id);
    _notifier.add(NewDatabaseEvent(NewDatabaseEventType.prop));
  }

  @override
  Stream<NewDatabaseEvent> stream() {
    return _notifier.stream;
  }

  @override
  void putBus(NewBus bus) async {
    _requireInitialized();
    await buses.put(bus.id, bus);
    _notifier.add(NewDatabaseEvent(NewDatabaseEventType.bus));
  }

  @override
  void putDriver(NewDriver driver) async {
    _requireInitialized();
    await drivers.put(driver.id, driver);
    _notifier.add(NewDatabaseEvent(NewDatabaseEventType.driver));
  }

  @override
  void putProp(NewProp prop) async {
    _requireInitialized();
    await props.put(prop.id, prop);
    _notifier.add(NewDatabaseEvent(NewDatabaseEventType.prop));
  }

  void _requireInitialized() {
    if (!Hive.isBoxOpen(buses.name)) {
      throw DatabaseError("""" "${buses.name}" box is not opened or not initialized . 
      please first open it then pass it to [HiveDatabase]""");
    }
    if (!Hive.isBoxOpen(drivers.name)) {
      throw DatabaseError(""" "${drivers.name}" box is not opened or not initialized . 
      please first open it then pass it to [HiveDatabase]""");
    }
    if (!Hive.isBoxOpen(props.name)) {
      throw DatabaseError(""" "${props.name}"  box is not opened or not initialized . 
      please first open it then pass it to [HiveDatabase]""");
    }
  }

  @override
  Iterable<NewBus> getBuses() {
    _requireInitialized();
    return buses.values;
  }

  @override
  Iterable<NewDriver> getDrivers() {
    _requireInitialized();
    return drivers.values;
  }

  @override
  Iterable<NewProp> getProps() {
    _requireInitialized();
    return props.values;
  }

  @override
  NewBus? getBus(String id) {
    _requireInitialized();
    return buses.get(id);
  }

  @override
  NewDriver? getDriver(String id) {
    _requireInitialized();
    return drivers.get(id);
  }

  @override
  NewProp? getProp(String id) {
    _requireInitialized();
    return props.get(id);
  }
}

class DatabaseError extends Error {
  final String message;

  DatabaseError(this.message);

  @override
  String toString() {
    return 'HiveError: $message';
  }
}

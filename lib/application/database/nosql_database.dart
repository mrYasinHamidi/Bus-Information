import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_bus_information/application/database/database_error.dart';
import 'package:new_bus_information/application/database/database_event.dart';
import 'package:new_bus_information/application/models/new_bus.dart';
import 'package:new_bus_information/application/models/new_driver.dart';
import 'package:new_bus_information/application/models/new_prop.dart';

import 'database.dart';

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
  bool containsBus(String code) {
    _requireInitialized();
    return buses.values
        .firstWhere(
          (element) => element.code == code,
          orElse: () => NewBus(),
        )
        .isNotEmpty();
  }

  @override
  bool containsDriver(String name) {
    _requireInitialized();
    return drivers.values
        .firstWhere(
          (element) => element.name == name,
          orElse: () => NewDriver(),
        )
        .isNotEmpty();
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

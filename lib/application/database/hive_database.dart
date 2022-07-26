import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_bus_information/application/database/database_error.dart';
import 'package:new_bus_information/application/database/database_event.dart';
import 'package:new_bus_information/application/database/database_event_type.dart';
import 'package:new_bus_information/application/models/bus/bus.dart';
import 'package:new_bus_information/application/models/driver/driver.dart';
import 'package:new_bus_information/application/models/prop/prop.dart';

import 'database.dart';

class HiveDatabase implements Database {
  HiveDatabase(
    this.buses,
    this.drivers,
    this.props,
  );

  final Box<Prop> props;
  final Box<Driver> drivers;
  final Box<Bus> buses;

  final StreamController<DatabaseEvent> _controller = StreamController();

  @override
  bool containsBus(String code) {
    _requireInitialized();
    return buses.values
        .firstWhere(
          (element) => element.code == code,
          orElse: () => Bus(),
        )
        .isNotEmpty();
  }

  @override
  bool containsDriver(String name) {
    _requireInitialized();
    return drivers.values
        .firstWhere(
          (element) => element.name == name,
          orElse: () => Driver(),
        )
        .isNotEmpty();
  }

  @override
  void deleteBus(Bus bus) async {
    _requireInitialized();
    await buses.delete(bus.id);
    _controller.add(DatabaseEvent(DatabaseEventType.bus));
  }

  @override
  void deleteDriver(Driver driver) async {
    _requireInitialized();
    await drivers.delete(driver.id);
    _controller.add(DatabaseEvent(DatabaseEventType.driver));
  }

  @override
  void deleteProp(Prop prop) async {
    _requireInitialized();
    await props.delete(prop.id);
    _controller.add(DatabaseEvent(DatabaseEventType.prop));
  }

  @override
  Stream<DatabaseEvent> stream() {
    return _controller.stream;
  }

  @override
  void putBus(Bus bus) async {
    _requireInitialized();
    await buses.put(bus.id, bus);
    _controller.add(DatabaseEvent(DatabaseEventType.bus));
  }

  @override
  void putDriver(Driver driver) async {
    _requireInitialized();
    await drivers.put(driver.id, driver);
    _controller.add(DatabaseEvent(DatabaseEventType.driver));
  }

  @override
  void putProp(Prop prop) async {
    _requireInitialized();
    await props.put(prop.id, prop);
    _controller.add(DatabaseEvent(DatabaseEventType.prop));
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
  Iterable<Bus> getBuses() {
    _requireInitialized();
    return buses.values;
  }

  @override
  Iterable<Driver> getDrivers() {
    _requireInitialized();
    return drivers.values;
  }

  @override
  Iterable<Prop> getProps() {
    _requireInitialized();
    return props.values;
  }

  @override
  Bus? getBus(String id) {
    _requireInitialized();
    return buses.get(id);
  }

  @override
  Driver? getDriver(String id) {
    _requireInitialized();
    return drivers.get(id);
  }

  @override
  Prop? getProp(String id) {
    _requireInitialized();
    return props.get(id);
  }
}

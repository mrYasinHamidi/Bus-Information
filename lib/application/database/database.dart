import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bus_information/application/database/database_event.dart';
import 'package:new_bus_information/application/models/bus/bus.dart';
import 'package:new_bus_information/application/models/driver/driver.dart';
import 'package:new_bus_information/application/models/prop/prop.dart';

abstract class NewDatabase {
  static NewDatabase of(BuildContext context) => context.read<NewDatabase>();

  void putBus(Bus bus);
  void putDriver(Driver driver);
  void putProp(Prop prop);

  void deleteBus(Bus bus);
  void deleteDriver(Driver driver);
  void deleteProp(Prop prop);

  bool containsBus(String code);
  bool containsDriver(String name);

  Iterable<Bus> getBuses();
  Iterable<Driver> getDrivers();
  Iterable<Prop> getProps();

  Bus? getBus(String id);
  Driver? getDriver(String id);
  Prop? getProp(String id);

  Stream<NewDatabaseEvent> stream();
}

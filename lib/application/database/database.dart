import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bus_information/application/database/database_event.dart';
import 'package:new_bus_information/application/models/new_bus.dart';
import 'package:new_bus_information/application/models/new_driver.dart';
import 'package:new_bus_information/application/models/new_prop.dart';

abstract class NewDatabase {
  static NewDatabase of(BuildContext context) => context.read<NewDatabase>();

  void putBus(NewBus bus);
  void putDriver(NewDriver driver);
  void putProp(NewProp prop);

  void deleteBus(NewBus bus);
  void deleteDriver(NewDriver driver);
  void deleteProp(NewProp prop);

  bool containsBus(String code);
  bool containsDriver(String name);

  Iterable<NewBus> getBuses();
  Iterable<NewDriver> getDrivers();
  Iterable<NewProp> getProps();

  NewBus? getBus(String id);
  NewDriver? getDriver(String id);
  NewProp? getProp(String id);

  Stream<NewDatabaseEvent> stream();
}

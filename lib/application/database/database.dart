import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bus_information/application/database/database_event.dart';
import 'package:bus_information/application/models/bus/bus.dart';
import 'package:bus_information/application/models/driver/driver.dart';
import 'package:bus_information/application/models/prop/prop.dart';

abstract class Database {
  static Database of(BuildContext context) => context.read<Database>();

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

  Stream<DatabaseEvent> stream();
}

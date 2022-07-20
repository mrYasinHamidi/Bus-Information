// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:objectid/objectid.dart';

import 'package:new_bus_information/application/models/bus/bus_status.dart';
import 'package:new_bus_information/application/models/driver/driver_status.dart';
import 'package:new_bus_information/application/models/driver/shift_work.dart';

class NewDriver extends Equatable {
  final String id;
  final String name;
  final DriverStatus status;
  final ShiftWork shiftWork;
  NewDriver({
    String? id,
    this.name = '',
    this.shiftWork = ShiftWork.morning,
    this.status = DriverStatus.active,
  }) : id = id ?? ObjectId().hexString;

  @override
  List<Object?> get props => [id];

  NewDriver copyWith({
    String? id,
    String? name,
    DriverStatus? status,
    ShiftWork? shiftWork,
  }) {
    return NewDriver(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      shiftWork: shiftWork ?? this.shiftWork,
    );
  }

  DateTime getCreationTime() {
    return ObjectId.fromHexString(id).timestamp;
  }

  bool isEmpty() {
    return name.isEmpty;
  }
}

class NewBus extends Equatable {
  final String id;
  final String code;
  final BusStatus status;
  NewBus({
    String? id,
    this.code = '',
    this.status = BusStatus.active,
  }) : id = id ?? ObjectId().hexString;

  @override
  List<Object?> get props => [id];

  NewBus copyWith({
    String? id,
    String? code,
    BusStatus? status,
  }) {
    return NewBus(
      id: id ?? this.id,
      code: code ?? this.code,
      status: status ?? this.status,
    );
  }

  DateTime getCreationTime() {
    return ObjectId.fromHexString(id).timestamp;
  }

  bool isEmpty() {
    return code.isEmpty;
  }
}

class NewProp extends Equatable {
  final String id;
  final String bus;
  final String driver;
  final String alternativeDriver;

  NewProp({
    String? id,
    this.bus = '',
    this.driver = '',
    this.alternativeDriver = '',
  }) : id = id ?? ObjectId().hexString;

  DateTime getCreationTime() {
    return ObjectId.fromHexString(id).timestamp;
  }

  @override
  List<Object?> get props => [id];

  NewProp copyWith({
    String? id,
    String? bus,
    String? driver,
    String? alternativeDriver,
  }) {
    return NewProp(
      id: id ?? this.id,
      bus: bus ?? this.bus,
      driver: driver ?? this.driver,
      alternativeDriver: alternativeDriver ?? this.alternativeDriver,
    );
  }

  bool isEmpty() {
    return bus.isEmpty && driver.isEmpty && alternativeDriver.isEmpty;
  }
}

enum NewDatabaseEventType {
  prop,driver,bus
}

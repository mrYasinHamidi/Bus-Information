import 'dart:convert';

import 'package:new_bus_information/application/models/base_object.dart';
import 'package:new_bus_information/application/models/base_object_type.dart';
import 'package:new_bus_information/application/models/driver/driver_status.dart';
import 'package:new_bus_information/application/models/driver/shift_work.dart';

class Driver implements BaseObject {
  final String name;
  final ShiftWork shiftWork;
  final DriverStatus status;
  final DateTime time;

  Driver({
    required this.name,
    required this.time,
    required this.status,
    required this.shiftWork,
  });

  factory Driver.fromJson(String json) {
    Map data = jsonDecode(json);
    return Driver(
      name: data['name'],
      time: DateTime.parse(data['time']),
      status: DriverStatus.values[data['status'] ?? 0],
      shiftWork: ShiftWork.values[data['shiftWork'] ?? 0],
    );
  }

  @override
  List<Object?> get props => [name];

  @override
  bool? get stringify => true;

  @override
  String toJson() {
    Map data = {
      'name': name,
      'status': status.index,
      'shiftWork': shiftWork.index,
      'time': time.toString(),
    };
    return jsonEncode(data);
  }

  @override
  BaseObjectType get type => BaseObjectType.driver;

  @override
  String get key => name;
}

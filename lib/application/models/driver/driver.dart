import 'dart:convert';

import 'package:new_bus_information/application/models/base_object.dart';
import 'package:new_bus_information/application/models/base_object_type.dart';
import 'package:new_bus_information/application/models/driver/driver_status.dart';
import 'package:new_bus_information/application/models/driver/shift_work.dart';
import 'package:objectid/objectid.dart';

class Driver implements BaseObject {
  final String id;
  final String name;
  final ShiftWork shiftWork;
  final DriverStatus status;

  Driver({
    String? id,
    required this.name,
    required this.status,
    required this.shiftWork,
  }) : id = id ?? ObjectId().hexString;

  factory Driver.fromJson(String json) {
    Map data = jsonDecode(json);
    return Driver(
      id: data['id'],
      name: data['name'],
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
      'id': id,
      'name': name,
      'status': status.index,
      'shiftWork': shiftWork.index,
    };
    return jsonEncode(data);
  }

  @override
  BaseObjectType get type => BaseObjectType.driver;

  @override
  String get key => id;

  DateTime get creationTime => ObjectId.fromHexString(id).timestamp;
}

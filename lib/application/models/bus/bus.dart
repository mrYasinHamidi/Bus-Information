import 'dart:convert';

import 'package:new_bus_information/application/models/base_object.dart';
import 'package:new_bus_information/application/models/base_object_type.dart';
import 'package:new_bus_information/application/models/bus/bus_status.dart';

class Bus implements BaseObject {
  final String id;
  final BusStatus status;
  final DateTime time;

  const Bus({required this.id, required this.status, required this.time});

  factory Bus.fromJson(String json) {
    Map data = jsonDecode(json);
    return Bus(
      id: data['id'],
      status: BusStatus.values[data['status'] ?? 0],
      time: DateTime.parse(data['time']),
    );
  }

  factory Bus.fromId(String id) {
    return Bus(id: id, time: DateTime.now(), status: BusStatus.active);
  }

  @override
  List<Object?> get props => [id];

  @override
  bool? get stringify => true;

  @override
  String toJson() {
    Map data = {
      'busNumber': id,
      'status': status.index,
      'time': time.toString(),
    };
    return jsonEncode(data);
  }

  @override
  BaseObjectType get type => BaseObjectType.bus;

  @override
  String get key => id;

  @override
  String get searchKey => id;
}

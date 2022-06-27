import 'dart:convert';

import 'package:new_bus_information/application/models/base_object.dart';
import 'package:new_bus_information/application/models/base_object_type.dart';
import 'package:new_bus_information/application/models/bus/bus_status.dart';
import 'package:objectid/objectid.dart';

class Bus implements BaseObject {
  final String id;
  final String busCode;
  final BusStatus status;

  Bus({
    String? id,
    required this.busCode,
    required this.status,
  }) : id = id ?? ObjectId().hexString;

  factory Bus.fromJson(String json) {
    Map data = jsonDecode(json);
    return Bus(
      id: data['id'],
      busCode: data['busCode'],
      status: BusStatus.values[data['status'] ?? 0],
    );
  }


  @override
  List<Object?> get props => [id];

  @override
  bool? get stringify => true;

  @override
  String toJson() {
    Map data = {
      'id': id,
      'busCode': busCode,
      'status': status.index,
    };
    return jsonEncode(data);
  }

  @override
  BaseObjectType get type => BaseObjectType.bus;

  @override
  String get key => id;

  DateTime get creationTime => ObjectId.fromHexString(id).timestamp;
}

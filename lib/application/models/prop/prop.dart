import 'dart:convert';
import 'package:new_bus_information/application/models/base/base_object.dart';
import 'package:new_bus_information/application/models/base/base_object_type.dart';
import 'package:new_bus_information/application/models/bus/bus.dart';
import 'package:new_bus_information/application/models/driver/driver.dart';
import 'package:objectid/objectid.dart';


class Prop implements BaseObject {
  final String id;
  final String? driverId;
  final String? busId;
  final String? secondDriverId;

  Bus? bus;
  Driver? firstDriver;
  Driver? secondDriver;

  Prop({
    String? id,
    this.busId,
    this.secondDriverId,
    this.driverId,
  }) : id = id ?? ObjectId().hexString;

  factory Prop.fromJson(String source) {
    Map data = jsonDecode(source);
    return Prop(
      id: data['id'],
      driverId: data['driverId'],
      secondDriverId: data['secondDriverId'],
      busId: data['busId'],
    );
  }

  DateTime get creationTime => ObjectId.fromHexString(id).timestamp;

  @override
  String get key => id;

  @override
  String toJson() {
    Map data = {
      'id': id,
      'driverId': driverId,
      'secondDriverId': secondDriverId,
      'busId': busId,
    };
    return jsonEncode(data);
  }

  @override
  List<Object?> get props => [id];

  @override
  bool? get stringify => true;

  @override
  BaseObjectType get type => BaseObjectType.prop;
}

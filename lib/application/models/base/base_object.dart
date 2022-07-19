import 'package:equatable/equatable.dart';
import 'package:new_bus_information/application/models/base/base_object_type.dart';

abstract class BaseObject extends Equatable {
  String get key;

  BaseObjectType get type;

  String toJson();
}

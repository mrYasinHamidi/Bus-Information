import 'package:equatable/equatable.dart';

enum BaseObjectType { driver, bus }

abstract class BaseObject extends Equatable {

  BaseObjectType get type;

  void toJson();

  void fromJson(String json);
}

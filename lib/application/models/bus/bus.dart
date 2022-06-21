import 'package:new_bus_information/application/models/base_object.dart';

class Bus implements BaseObject {
  final String id;

  Bus({required this.id});

  factory Bus.fromJson(String json) {
    return Bus(id: '')..fromJson(json);
  }

  @override
  List<Object?> get props => [id];

  @override
  bool? get stringify => true;

  @override
  void toJson() {}

  @override
  void fromJson(String json) {}

  @override
  BaseObjectType get type => BaseObjectType.bus;
}

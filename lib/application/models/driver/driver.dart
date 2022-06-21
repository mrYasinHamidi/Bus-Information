import 'package:new_bus_information/application/models/base_object.dart';

class Driver implements BaseObject {
  final String id;

  Driver({required this.id});

  factory Driver.fromJson(String json) {
    return Driver(id: '')..fromJson(json);
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
  BaseObjectType get type => BaseObjectType.driver;
}

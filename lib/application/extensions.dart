import 'package:new_bus_information/application/models/base_object.dart';
import 'package:new_bus_information/application/models/base_object_type.dart';
import 'package:new_bus_information/application/models/bus/bus.dart';
import 'package:new_bus_information/application/models/driver/driver.dart';
import 'package:objectid/objectid.dart';

extension ObjectList on List<BaseObject> {
  void reSort() {
    sort((a, b) => ObjectId.fromHexString(b.key).timestamp.compareTo(ObjectId.fromHexString(a.key).timestamp));
  }
}

extension ObjectExtension on BaseObject {
  String get searchTerm {
    switch (type) {
      case BaseObjectType.driver:
        return (this as Driver).name;
      case BaseObjectType.bus:
        return (this as Bus).busCode;
      case BaseObjectType.prop:
        return '';
    }
  }
}

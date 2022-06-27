import 'package:new_bus_information/application/models/base_object.dart';
import 'package:objectid/objectid.dart';

extension ObjectList on List<BaseObject> {
  void reSort() {
    sort((a, b) => ObjectId.fromHexString(b.key).timestamp.compareTo(ObjectId.fromHexString(a.key).timestamp));
  }
}

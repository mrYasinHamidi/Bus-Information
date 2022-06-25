import 'package:new_bus_information/application/models/base_object.dart';
import 'package:objectid/objectid.dart';

extension BaseObjectExtension on BaseObject {
  DateTime get creationTime => ObjectId.fromHexString(key).timestamp;
}

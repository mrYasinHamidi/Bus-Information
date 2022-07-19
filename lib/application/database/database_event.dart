import 'package:new_bus_information/application/models/base/base_object.dart';

enum DatabaseEventType {
  put,
  delete,
}

class DatabaseEvent {
  final BaseObject object;
  final DatabaseEventType eventType;

  const DatabaseEvent({
    required this.object,
    required this.eventType,
  });
}

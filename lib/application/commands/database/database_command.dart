import 'package:new_bus_information/application/commands/command.dart';
import 'package:new_bus_information/application/commands/database/database_command_type.dart';
import 'package:new_bus_information/application/database/database.dart';
import 'package:new_bus_information/application/models/base/base_object.dart';

class DatabaseCommand implements Command {
  DatabaseCommandType type;
  BaseObject object;
  Database dataBase;

  DatabaseCommand({
    required this.type,
    required this.object,
    required this.dataBase,
  });

  @override
  void execute() {
    if (type == DatabaseCommandType.save) {
      dataBase.put(object);
      return;
    }
    if (type == DatabaseCommandType.delete) {
      dataBase.delete(object);
      return;
    }
    if (type == DatabaseCommandType.update) {
      dataBase.put(object);
      return;
    }
  }
}

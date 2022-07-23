enum NewDatabaseEventType { prop, driver, bus }

class NewDatabaseEvent {
  final NewDatabaseEventType type;

  NewDatabaseEvent(this.type);
}

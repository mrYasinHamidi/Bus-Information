import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:new_bus_information/application/database/database.dart';
import 'package:new_bus_information/application/database/database_event.dart';
import 'package:new_bus_information/application/models/base_object.dart';
import 'package:new_bus_information/application/models/base_object_type.dart';

part 'object_list_state.dart';

class ObjectListCubit<T extends BaseObject> extends Cubit<ObjectListState> {
  final Database database;
  final BaseObjectType type;
  late StreamSubscription<DatabaseEvent> streamSubscription;

  ObjectListCubit({
    required this.database,
    required this.type,
  }) : super(ObjectListState(objects: database.getObjects(type))) {
    streamSubscription = database.listen().listen(_databaseListener);
  }

  void _databaseListener(DatabaseEvent event) {
    switch (event.eventType) {
      case DatabaseEventType.put:
        emit(state.copyWith(objects: [event.object, ...state.objects]));
        break;
      case DatabaseEventType.delete:
        emit(state.copyWith(objects: state.objects..removeWhere((element) => element == event.object)));
        break;
    }
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}

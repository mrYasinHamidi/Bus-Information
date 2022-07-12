import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_bus_information/application/cubit/objectList/object_list_cubit.dart';
import 'package:new_bus_information/application/models/prop/prop.dart';

part 'filter_prop_state.dart';

class FilterPropCubit extends Cubit<FilterPropState> {
  final ObjectListCubit<Prop> objectListCubit;

  late StreamSubscription objectListSubscription;

  FilterPropCubit({required this.objectListCubit}) : super(FilterPropState.initial()) {
    objectListSubscription = objectListCubit.stream.listen((ObjectListState event) {
      _setFilteredProp();
    });
    //becuase in first launch of application stream subscription
    //dos not recognize the initial state of blocs
    //we should do the filtered operations on this blocs once a time
    _setFilteredProp();
  }

  _setFilteredProp() {
    List<Prop> filteredProps = [];

    filteredProps = objectListCubit.state.objects;
    emit(state.copyWith(filteredList: filteredProps));
  }

  @override
  Future<void> close() {
    objectListSubscription.cancel();
    return super.close();
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_bus_information/application/models/prop/prop.dart';

part 'filter_prop_state.dart';

class FilterPropCubit extends Cubit<FilterPropState> {
  FilterPropCubit() : super(FilterPropState.initial());
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_bus_information/application/models/bus/bus_status.dart';
import 'package:new_bus_information/generated/l10n.dart';

part 'filter_terms_event.dart';
part 'filter_terms_state.dart';

class FilterTermsBloc extends Bloc<FilterTermsEvent, FilterTermsState> {
  FilterTermsBloc() : super(FilterTermsState.initial()) {
    on<SetSearchCondidateEvent>(changeSearchCondidate);
    on<SetBusStatusCondidateEvent>(changeBusStatusCondidate);
  }

  void changeSearchCondidate(SetSearchCondidateEvent event, Emitter emit) {
    if (state.searchCondidates.contains(event.newCondidate)) {
      emit(state.copyWith(searchCondidates: {...state.searchCondidates}..remove(event.newCondidate)));
    } else {
      emit(state.copyWith(searchCondidates: {...state.searchCondidates, event.newCondidate}));
    }
  }

  void changeBusStatusCondidate(SetBusStatusCondidateEvent event, Emitter emit) {
    if (state.busStatusCondidate.contains(event.newStatus)) {
      emit(state.copyWith(busStatusCondidate: {...state.busStatusCondidate}..remove(event.newStatus)));
    } else {
      emit(state.copyWith(busStatusCondidate: {...state.busStatusCondidate, event.newStatus}));
    }
  }
}

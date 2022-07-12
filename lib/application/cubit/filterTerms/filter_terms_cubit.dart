import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_bus_information/generated/l10n.dart';

part 'filter_terms_state.dart';

class FilterTermsCubit extends Cubit<FilterTermsState> {
  FilterTermsCubit() : super(FilterTermsState.initial());

  void changeCondidate(SearchCondidateType condidateType) {
    if (state.searchCondidates.contains(condidateType)) {
      emit(state.copyWith(searchCondidates: {...state.searchCondidates}..remove(condidateType)));
    } else {
      emit(state.copyWith(searchCondidates: {...state.searchCondidates, condidateType}));
    }
  }
}

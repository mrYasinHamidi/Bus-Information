import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'filter_terms_state.dart';

class FilterTermsCubit extends Cubit<FilterTermsState> {
  FilterTermsCubit() : super(FilterTermsState.initial());

  void addGroup(SearchCondidateType newCondidate) {
    emit(state.copyWith(searchCondidates: state.searchCondidates..add(newCondidate)));
  }

  void removeGroup(SearchCondidateType oldCondidate) {
    emit(state.copyWith(searchCondidates: state.searchCondidates..remove(oldCondidate)));
  }
}

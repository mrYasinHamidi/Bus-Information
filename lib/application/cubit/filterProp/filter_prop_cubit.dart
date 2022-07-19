import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_bus_information/application/bloc/filterTerms/filter_terms_bloc.dart';
import 'package:new_bus_information/application/bloc/search/search_bloc.dart';
import 'package:new_bus_information/application/cubit/objectList/object_list_cubit.dart';
import 'package:new_bus_information/application/models/prop/prop.dart';
import 'package:new_bus_information/application/models/search_condidate_type.dart';

part 'filter_prop_state.dart';

class FilterPropCubit extends Cubit<FilterPropState> {
  final ObjectListCubit<Prop> objectListCubit;
  final SearchBloc searchBloc;
  final FilterTermsBloc filterTermsBloc;

  late StreamSubscription objectListSubscription;
  late StreamSubscription searchSubscription;
  late StreamSubscription filterTermsSubscription;

  FilterPropCubit({
    required this.objectListCubit,
    required this.searchBloc,
    required this.filterTermsBloc,
  }) : super(FilterPropState.initial()) {
    objectListSubscription = objectListCubit.stream.listen((ObjectListState event) {
      _setFilteredProp();
    });
    searchSubscription = searchBloc.stream.listen((SearchState event) {
      _setFilteredProp();
    });
    filterTermsSubscription = filterTermsBloc.stream.listen((FilterTermsState event) {
      _setFilteredProp();
    });

    //becuase in first launch of application stream subscription
    //dos not recognize the initial state of blocs
    //we should do the filtered operations on this blocs once a time
    _setFilteredProp();
  }

  _setFilteredProp() {
    List<Prop> filteredProps = objectListCubit.state.objects;

    if (searchBloc.state.searchTerm.isNotEmpty) {
      filteredProps = filteredProps
          .where((element) => _getSearchTerm(element).toLowerCase().contains(searchBloc.state.searchTerm.toLowerCase()))
          .toList();
    }
    if (filterTermsBloc.state.busStatusCondidate.isNotEmpty) {
      filteredProps = filteredProps
          .where((element) => filterTermsBloc.state.busStatusCondidate.contains(element.bus?.status))
          .toList();
    }
    if (filterTermsBloc.state.driverStatusCondidate.isNotEmpty) {
      filteredProps = filteredProps
          .where((element) => filterTermsBloc.state.driverStatusCondidate.contains(element.firstDriver?.status))
          .toList();
    }
    if (filterTermsBloc.state.driverShiftCondidate.isNotEmpty) {
      filteredProps = filteredProps
          .where((element) => filterTermsBloc.state.driverShiftCondidate.contains(element.firstDriver?.shiftWork))
          .toList();
    }
    if (filterTermsBloc.state.secondDriverStatusCondidate.isNotEmpty) {
      filteredProps = filteredProps
          .where((element) => filterTermsBloc.state.secondDriverStatusCondidate.contains(element.secondDriver?.status))
          .toList();
    }
    if (filterTermsBloc.state.secondDriverShiftCondidate.isNotEmpty) {
      filteredProps = filteredProps
          .where(
              (element) => filterTermsBloc.state.secondDriverShiftCondidate.contains(element.secondDriver?.shiftWork))
          .toList();
    }

    emit(state.copyWith(filteredList: filteredProps));
  }

  String _getSearchTerm(Prop prop) {
    String term = '';
    Set condidates = filterTermsBloc.state.searchCondidates;
    if (condidates.contains(SearchCondidateType.bus)) {
      term += prop.bus?.busCode ?? '';
    }
    if (condidates.contains(SearchCondidateType.firstDriver)) {
      term += prop.firstDriver?.name ?? '';
    }
    if (condidates.contains(SearchCondidateType.secondDriver)) {
      term += prop.secondDriver?.name ?? '';
    }
    return term;
  }

  @override
  Future<void> close() {
    objectListSubscription.cancel();
    filterTermsSubscription.cancel();
    searchSubscription.cancel();
    return super.close();
  }
}

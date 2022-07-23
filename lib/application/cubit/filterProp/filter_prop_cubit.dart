import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_bus_information/application/bloc/filterTerms/filter_terms_bloc.dart';
import 'package:new_bus_information/application/bloc/search/search_bloc.dart';
import 'package:new_bus_information/application/database/database.dart';
import 'package:new_bus_information/application/database/database_event.dart';
import 'package:new_bus_information/application/models/new_prop.dart';
import 'package:new_bus_information/application/models/search_condidate_type.dart';

part 'filter_prop_state.dart';

class FilterPropCubit extends Cubit<FilterPropState> {
  final NewDatabase database;
  final SearchBloc searchBloc;
  final FilterTermsBloc filterTermsBloc;

  late StreamSubscription databaseSubscription;
  late StreamSubscription searchSubscription;
  late StreamSubscription filterTermsSubscription;

  FilterPropCubit({
    required this.database,
    required this.searchBloc,
    required this.filterTermsBloc,
  }) : super(FilterPropState.initial()) {
    databaseSubscription = database.stream().listen((NewDatabaseEvent event) {
      if (event.type == NewDatabaseEventType.prop) {
        _setFilteredProp();
      }
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
    List<NewProp> filteredProps = database.getProps().toList();

    if (searchBloc.state.searchTerm.isNotEmpty) {
      filteredProps = filteredProps
          .where((element) =>
              getSearchTerm(database, element).toLowerCase().contains(searchBloc.state.searchTerm.toLowerCase()))
          .toList();
    }
    if (filterTermsBloc.state.busStatusCondidate.isNotEmpty) {
      filteredProps = filteredProps
          .where(
            (element) => filterTermsBloc.state.busStatusCondidate.contains(
              database.getBus(element.bus)?.status,
            ),
          )
          .toList();
    }
    if (filterTermsBloc.state.driverStatusCondidate.isNotEmpty) {
      filteredProps = filteredProps
          .where(
            (element) => filterTermsBloc.state.driverStatusCondidate.contains(
              database.getDriver(element.driver)?.status,
            ),
          )
          .toList();
    }
    if (filterTermsBloc.state.driverShiftCondidate.isNotEmpty) {
      filteredProps = filteredProps
          .where(
            (element) => filterTermsBloc.state.driverShiftCondidate.contains(
              database.getDriver(element.driver)?.shiftWork,
            ),
          )
          .toList();
    }
    if (filterTermsBloc.state.secondDriverStatusCondidate.isNotEmpty) {
      filteredProps = filteredProps
          .where(
            (element) => filterTermsBloc.state.secondDriverStatusCondidate.contains(
              database.getDriver(element.alternativeDriver)?.status,
            ),
          )
          .toList();
    }
    if (filterTermsBloc.state.secondDriverShiftCondidate.isNotEmpty) {
      filteredProps = filteredProps
          .where(
            (element) => filterTermsBloc.state.secondDriverShiftCondidate.contains(
              database.getDriver(element.alternativeDriver)?.shiftWork,
            ),
          )
          .toList();
    }

    emit(state.copyWith(filteredList: filteredProps));
  }

  String getSearchTerm(NewDatabase database, NewProp prop) {
    String term = '';
    Set condidates = filterTermsBloc.state.searchCondidates;
    if (condidates.contains(SearchCondidateType.bus)) {
      term += database.getBus(prop.bus)?.code ?? '';
    }
    if (condidates.contains(SearchCondidateType.firstDriver)) {
      term += database.getDriver(prop.driver)?.name ?? '';
    }
    if (condidates.contains(SearchCondidateType.secondDriver)) {
      term += database.getDriver(prop.alternativeDriver)?.name ?? '';
    }
    return term;
  }

  @override
  Future<void> close() {
    databaseSubscription.cancel();
    filterTermsSubscription.cancel();
    searchSubscription.cancel();
    return super.close();
  }
}

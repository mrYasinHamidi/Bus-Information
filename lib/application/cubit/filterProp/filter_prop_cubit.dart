import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bus_information/application/bloc/filterTerms/filter_terms_bloc.dart';
import 'package:bus_information/application/bloc/search/search_bloc.dart';
import 'package:bus_information/application/database/database.dart';
import 'package:bus_information/application/database/database_event.dart';
import 'package:bus_information/application/models/date/date.dart';
import 'package:bus_information/application/models/prop/prop.dart';
import 'package:bus_information/application/models/search_condidate_type.dart';

part 'filter_prop_state.dart';

///bloc associated with [PropListPage]
///this bloc listen to [FilterTermBloc] [Database] and [SearchBloc]
/// 1 . getting list of all prop from [Database]
/// 2 . searching in props with [SearchState]
/// 3 . setting filter terms form [FilterTermsBloc]
/// 4 . emmiting the final List of props to ui

class FilterPropCubit extends Cubit<FilterPropState> {
  final Database database;
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
    databaseSubscription = database.stream().listen((DatabaseEvent event) {
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

  ///setting search term and filter terms to list and emitting to ui
  _setFilteredProp() {
    List<Prop> filteredProps = database.getProps().toList();

    if (searchBloc.state.searchTerm.isNotEmpty) {
      filteredProps = filteredProps
          .where((element) =>
              _getPropSerchWord(database, element).toLowerCase().contains(searchBloc.state.searchTerm.toLowerCase()))
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
    if (!filterTermsBloc.state.startDate.isZero()) {
      filteredProps = filteredProps
          .where(
            (element) => Date.fromDateTime(element.getCreationTime()).isAfterOrEqual(filterTermsBloc.state.startDate),
          )
          .toList();
    }
    if (!filterTermsBloc.state.endDate.isZero()) {
      filteredProps = filteredProps
          .where(
            (element) => Date.fromDateTime(element.getCreationTime()).isBeforeOrEqual(filterTermsBloc.state.endDate),
          )
          .toList();
    }

    emit(state.copyWith(filteredList: filteredProps));
  }

  ///what part of a [Prop] should use for searching?
  ///First driver name , alternative driver name or bus code ?
  ///1 . get the first driver , alternative driver and bus instances from database
  ///2 . get search condidate from [FilterTermsBloc]
  ///3 . return the the final word for searching
  String _getPropSerchWord(Database database, Prop prop) {
    String term = '';
    Set condidates = filterTermsBloc.state.searchCondidates;
    if (condidates.isEmpty || condidates.contains(SearchCondidateType.bus)) {
      term += database.getBus(prop.bus)?.code ?? '';
    }
    if (condidates.isEmpty || condidates.contains(SearchCondidateType.firstDriver)) {
      term += database.getDriver(prop.driver)?.name ?? '';
    }
    if (condidates.isEmpty || condidates.contains(SearchCondidateType.secondDriver)) {
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

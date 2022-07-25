// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filter_terms_bloc.dart';

class FilterTermsState extends Equatable {
  final Set<SearchCondidateType> searchCondidates;
  final Set<BusStatus> busStatusCondidate;
  final Set<DriverStatus> driverStatusCondidate;
  final Set<ShiftWork> driverShiftCondidate;
  final Set<DriverStatus> secondDriverStatusCondidate;
  final Set<ShiftWork> secondDriverShiftCondidate;
  final Date startDate;
  final Date endDate;

  const FilterTermsState({
    required this.searchCondidates,
    required this.busStatusCondidate,
    required this.driverShiftCondidate,
    required this.driverStatusCondidate,
    required this.secondDriverShiftCondidate,
    required this.secondDriverStatusCondidate,
    required this.startDate,
    required this.endDate,
  });

  factory FilterTermsState.initial() {
    return const FilterTermsState(
      searchCondidates: {},
      busStatusCondidate: {},
      driverShiftCondidate: {},
      driverStatusCondidate: {},
      secondDriverShiftCondidate: {},
      secondDriverStatusCondidate: {},
      endDate: Date.zero(),
      startDate: Date.zero(),
    );
  }

  @override
  List<Object> get props => [
        searchCondidates,
        busStatusCondidate,
        driverStatusCondidate,
        driverShiftCondidate,
        secondDriverStatusCondidate,
        secondDriverShiftCondidate,
        startDate,
        endDate,
      ];

  FilterTermsState copyWith({
    Set<SearchCondidateType>? searchCondidates,
    Set<BusStatus>? busStatusCondidate,
    Set<DriverStatus>? driverStatusCondidate,
    Set<ShiftWork>? driverShiftCondidate,
    Set<DriverStatus>? secondDriverStatusCondidate,
    Set<ShiftWork>? secondDriverShiftCondidate,
    Date? startDate,
    Date? endDate,
  }) {
    return FilterTermsState(
      searchCondidates: searchCondidates ?? this.searchCondidates,
      busStatusCondidate: busStatusCondidate ?? this.busStatusCondidate,
      driverStatusCondidate: driverStatusCondidate ?? this.driverStatusCondidate,
      driverShiftCondidate: driverShiftCondidate ?? this.driverShiftCondidate,
      secondDriverStatusCondidate: secondDriverStatusCondidate ?? this.secondDriverStatusCondidate,
      secondDriverShiftCondidate: secondDriverShiftCondidate ?? this.secondDriverShiftCondidate,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}

extension FilterTermsExtension on FilterTermsState {
  Map<String, bool> get searchCondidateAsMap => {
        for (SearchCondidateType e in SearchCondidateType.values) e.text: searchCondidates.contains(e),
      };

  Map<String, bool> get busStatusCondidateAsMap => {
        for (BusStatus e in BusStatus.values) e.text: busStatusCondidate.contains(e),
      };

  Map<String, bool> get driverStatusCondidateAsMap => {
        for (DriverStatus e in DriverStatus.values) e.text: driverStatusCondidate.contains(e),
      };

  Map<String, bool> get driverShiftCondidateAsMap => {
        for (ShiftWork e in ShiftWork.values) e.text: driverShiftCondidate.contains(e),
      };

  Map<String, bool> get secondDriverStatusCondidateAsMap => {
        for (DriverStatus e in DriverStatus.values) e.text: secondDriverStatusCondidate.contains(e),
      };

  Map<String, bool> get secondDriverShiftCondidateAsMap => {
        for (ShiftWork e in ShiftWork.values) e.text: secondDriverShiftCondidate.contains(e),
      };
}

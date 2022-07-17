part of 'filter_terms_bloc.dart';

enum SearchCondidateType { bus, firstDriver, secondDriver }

class FilterTermsState extends Equatable {
  final Set<SearchCondidateType> searchCondidates;
  final Set<BusStatus> busStatusCondidate;

  const FilterTermsState({
    required this.searchCondidates,
    required this.busStatusCondidate,
  });

  factory FilterTermsState.initial() {
    return const FilterTermsState(
      searchCondidates: {},
      busStatusCondidate: {},
    );
  }

  Map<String, bool> get searchCondidateAsMap => {
        for (SearchCondidateType e in SearchCondidateType.values) e.text: searchCondidates.contains(e),
      };

  Map<String, bool> get busStatusCondidateAsMap => {
        for (BusStatus e in BusStatus.values) e.text: busStatusCondidate.contains(e),
      };

  @override
  List<Object> get props => [searchCondidates,busStatusCondidate];

  FilterTermsState copyWith({
    Set<SearchCondidateType>? searchCondidates,
    Set<BusStatus>? busStatusCondidate,
  }) {
    return FilterTermsState(
      searchCondidates: searchCondidates ?? this.searchCondidates,
      busStatusCondidate: busStatusCondidate ?? this.busStatusCondidate,
    );
  }
}

extension CondidateExtension on SearchCondidateType {
  String get text {
    switch (this) {
      case SearchCondidateType.bus:
        return S.current.bus;
      case SearchCondidateType.firstDriver:
        return S.current.driver;
      case SearchCondidateType.secondDriver:
        return S.current.alternativeDriver;
    }
  }
}

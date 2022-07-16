// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filter_terms_cubit.dart';

enum SearchCondidateType { bus, firstDriver, secondDriver }

class FilterTermsState extends Equatable {
  final Set<SearchCondidateType> searchCondidates;

  const FilterTermsState({required this.searchCondidates});

  factory FilterTermsState.initial() {
    return const FilterTermsState(searchCondidates: {SearchCondidateType.bus});
  }

  Map<String, bool> get condidateAsMap => {
        for (SearchCondidateType e in SearchCondidateType.values) e.text: searchCondidates.contains(e),
      };
  @override
  List<Object> get props => [searchCondidates];

  FilterTermsState copyWith({
    Set<SearchCondidateType>? searchCondidates,
  }) {
    return FilterTermsState(
      searchCondidates: searchCondidates ?? this.searchCondidates,
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

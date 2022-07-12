// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filter_terms_cubit.dart';

enum SearchCondidateType { firstDriver, secondDriver, bus }

class FilterTermsState extends Equatable {
  final Set<SearchCondidateType> searchCondidates;

  const FilterTermsState({required this.searchCondidates});

  factory FilterTermsState.initial() {
    return const FilterTermsState(searchCondidates: {SearchCondidateType.firstDriver});
  }

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

part of 'search_bloc.dart';

class SearchState extends Equatable {
  final String searchTerm;
  final bool isActive;
  const SearchState({
    required this.searchTerm,
    required this.isActive,
  });
  factory SearchState.initial() {
    return const SearchState(searchTerm: '', isActive: true);
  }

  @override
  List<Object> get props => [searchTerm,isActive];

  SearchState copyWith({
    String? searchTerm,
    bool? isActive,
  }) {
    return SearchState(
      searchTerm: searchTerm ?? this.searchTerm,
      isActive: isActive ?? this.isActive,
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filter_prop_cubit.dart';

class FilterPropState {
  final List<Prop> filteredList;
  const FilterPropState({required this.filteredList});

  factory FilterPropState.initial() {
    return const FilterPropState(filteredList: []);
  }

  FilterPropState copyWith({
    List<Prop>? filteredList,
  }) {
    return FilterPropState(
      filteredList: filteredList ?? this.filteredList,
    );
  }
}

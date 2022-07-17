part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SetSearchTermEvent extends SearchEvent {
  final String newSerchTerm;
  const SetSearchTermEvent({required this.newSerchTerm});

  @override
  List<Object> get props => [newSerchTerm];
}

class ActiveSearchEvent extends SearchEvent {}

class DeactiveSearchEvent extends SearchEvent {}

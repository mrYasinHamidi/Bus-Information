part of 'filter_terms_bloc.dart';

abstract class FilterTermsEvent extends Equatable {
  const FilterTermsEvent();

  @override
  List<Object> get props => [];
}

class SetSearchCondidateEvent extends FilterTermsEvent {
  final SearchCondidateType newCondidate;
  const SetSearchCondidateEvent({required this.newCondidate});
}

class SetBusStatusCondidateEvent extends FilterTermsEvent {
  final BusStatus newStatus;
  const SetBusStatusCondidateEvent({required this.newStatus});
}

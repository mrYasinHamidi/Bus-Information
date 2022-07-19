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

class SetDriverStatusCondidateEvent extends FilterTermsEvent {
  final DriverStatus newStatus;
  const SetDriverStatusCondidateEvent({required this.newStatus});
}

class SetDriverShiftCondidateEvent extends FilterTermsEvent {
  final ShiftWork newShift;
  const SetDriverShiftCondidateEvent({required this.newShift});
}

class SetSecondDriverStatusCondidateEvent extends FilterTermsEvent {
  final DriverStatus newStatus;
  const SetSecondDriverStatusCondidateEvent({required this.newStatus});
}

class SetSecondDriverShiftCondidateEvent extends FilterTermsEvent {
  final ShiftWork newShift;
  const SetSecondDriverShiftCondidateEvent({required this.newShift});
}

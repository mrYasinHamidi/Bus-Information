import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState.initial()) {
    on<SetSearchTermEvent>(
      (event, emit) {
        emit(state.copyWith(searchTerm: event.newSerchTerm));
      },
      transformer: debounce(
        const Duration(milliseconds: 300),
      ),
    );
    on<ActiveSearchEvent>((event, emit) {
      emit(state.copyWith(isActive: true));
    });
    on<DeactiveSearchEvent>((event, emit) {
      emit(state.copyWith(isActive: false));
    });
  }

  EventTransformer<SetSearchTermEvent> debounce<SetSearchTermEvent>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}

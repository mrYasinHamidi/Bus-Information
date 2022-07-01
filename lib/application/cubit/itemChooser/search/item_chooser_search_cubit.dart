import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'item_chooser_search_state.dart';

class ItemChooserSearchCubit extends Cubit<ItemChooserSearchState> {
  ItemChooserSearchCubit() : super(ItemChooserSearchInitial());
}

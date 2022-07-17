import 'package:flutter_test/flutter_test.dart';
import 'package:new_bus_information/application/bloc/search/search_bloc.dart';
import 'package:new_bus_information/application/cubit/filterProp/filter_prop_cubit.dart';
import 'package:new_bus_information/application/bloc/filterTerms/filter_terms_bloc.dart';
import 'package:new_bus_information/application/cubit/objectList/object_list_cubit.dart';
import 'package:new_bus_information/application/database/nosql_database.dart';
import 'package:new_bus_information/application/models/base_object_type.dart';

void main() {
  late FilterPropCubit sut;
  setUp(() {
    sut = FilterPropCubit(
      objectListCubit: ObjectListCubit(database: NoSqlDatabase(), type: BaseObjectType.prop),
      searchBloc: SearchBloc(),
      filterTermsBloc: FilterTermsBloc(),
    );
  });
  test('initialing', () {});
}

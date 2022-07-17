import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_bus_information/application/bloc/search/search_bloc.dart';
import 'package:new_bus_information/application/cubit/filterProp/filter_prop_cubit.dart';
import 'package:new_bus_information/application/bloc/filterTerms/filter_terms_bloc.dart';
import 'package:new_bus_information/application/cubit/language/language_cubit.dart';
import 'package:new_bus_information/application/cubit/objectList/object_list_cubit.dart';
import 'package:new_bus_information/application/cubit/theme/theme_cubit.dart';
import 'package:new_bus_information/application/database/database.dart';
import 'package:new_bus_information/application/database/nosql_database.dart';
import 'package:new_bus_information/application/models/base_object_type.dart';
import 'package:new_bus_information/application/models/prop/prop.dart';
import 'package:new_bus_information/application/pages/home_page.dart';
import 'package:new_bus_information/generated/l10n.dart';

void main() async {
  await Hive.initFlutter();
  await NoSqlDatabase.open();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<Database>(
      create: (context) => NoSqlDatabase(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LanguageCubit()),
          BlocProvider(create: (context) => ThemeCubit(languageCubit: context.read<LanguageCubit>())),
          BlocProvider(create: (context) => SearchBloc()),
          BlocProvider(create: (context) => FilterTermsBloc()),
          BlocProvider(
            create: (context) => ObjectListCubit<Prop>(
              database: context.read<Database>(),
              type: BaseObjectType.prop,
            ),
          ),
          BlocProvider(
            create: (context) => FilterPropCubit(
              objectListCubit: context.read<ObjectListCubit<Prop>>(),
              searchBloc: context.read<SearchBloc>(),
              filterTermsBloc: context.read<FilterTermsBloc>(),
            ),
          ),
        ],
        child: Builder(
          builder: (context) {
            return MaterialApp(
              home: const HomePage(),
              theme: context.watch<ThemeCubit>().state.theme,
              supportedLocales: S.delegate.supportedLocales,
              locale: context.watch<LanguageCubit>().state.locale,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      ),
    );
  }
}

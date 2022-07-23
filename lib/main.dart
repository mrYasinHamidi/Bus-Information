import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_bus_information/application/bloc/search/search_bloc.dart';
import 'package:new_bus_information/application/cubit/filterProp/filter_prop_cubit.dart';
import 'package:new_bus_information/application/bloc/filterTerms/filter_terms_bloc.dart';
import 'package:new_bus_information/application/cubit/language/language_cubit.dart';
import 'package:new_bus_information/application/cubit/theme/theme_cubit.dart';
import 'package:new_bus_information/application/database/database.dart';
import 'package:new_bus_information/application/database/nosql_database.dart';
import 'package:new_bus_information/application/models/bus/bus_status.dart';
import 'package:new_bus_information/application/models/driver/driver_status.dart';
import 'package:new_bus_information/application/models/driver/shift_work.dart';
import 'package:new_bus_information/application/models/new_bus.dart';
import 'package:new_bus_information/application/models/new_driver.dart';
import 'package:new_bus_information/application/models/new_prop.dart';
import 'package:new_bus_information/application/pages/home_page.dart';
import 'package:new_bus_information/generated/l10n.dart';

void main() async {
  await Hive.initFlutter();
  await NoSqlDatabase.open();
  Hive.registerAdapter(BusStatusAdapter());
  Hive.registerAdapter(DriverStatusAdapter());
  Hive.registerAdapter(ShiftWorkAdapter());
  Hive.registerAdapter(NewDriverAdapter());
  Hive.registerAdapter(NewBusAdapter());
  Hive.registerAdapter(NewPropAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<NewHiveDatabase> getDatabase() async {
      return NewHiveDatabase(
        await Hive.openBox('buses'),
        await Hive.openBox('drivers'),
        await Hive.openBox('props'),
      );
    }

    return FutureBuilder(
      future: getDatabase(),
      builder: (BuildContext context, AsyncSnapshot<NewDatabase> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return RepositoryProvider(
            create: (context) => snapshot.data,
            child: RepositoryProvider<Database>(
              create: (context) => NoSqlDatabase(),
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => LanguageCubit()),
                  BlocProvider(create: (context) => ThemeCubit(languageCubit: context.read<LanguageCubit>())),
                  BlocProvider(create: (context) => SearchBloc()),
                  BlocProvider(create: (context) => FilterTermsBloc()),
                  BlocProvider(
                    create: (context) => FilterPropCubit(
                      database: NewDatabase.of(context),
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
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

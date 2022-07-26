import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_bus_information/application/bloc/search/search_bloc.dart';
import 'package:new_bus_information/application/cubit/filterProp/filter_prop_cubit.dart';
import 'package:new_bus_information/application/bloc/filterTerms/filter_terms_bloc.dart';
import 'package:new_bus_information/application/cubit/language/language_cubit.dart';
import 'package:new_bus_information/application/cubit/settings/settings_cubit.dart';
import 'package:new_bus_information/application/cubit/theme/theme_cubit.dart';
import 'package:new_bus_information/application/database/database.dart';
import 'package:new_bus_information/application/database/hive_database.dart';
import 'package:new_bus_information/application/models/bus/bus_status.dart';
import 'package:new_bus_information/application/models/driver/driver_status.dart';
import 'package:new_bus_information/application/models/driver/shift_work.dart';
import 'package:new_bus_information/application/models/bus/bus.dart';
import 'package:new_bus_information/application/models/driver/driver.dart';
import 'package:new_bus_information/application/models/prop/prop.dart';
import 'package:new_bus_information/application/pages/home_page.dart';
import 'package:new_bus_information/generated/l10n.dart';

void main() async {
  await initHive();
  runApp(const MyApp());
}

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BusStatusAdapter());
  Hive.registerAdapter(DriverStatusAdapter());
  Hive.registerAdapter(ShiftWorkAdapter());
  Hive.registerAdapter(DriverAdapter());
  Hive.registerAdapter(BusAdapter());
  Hive.registerAdapter(PropAdapter());
  await Hive.openBox<bool>('settings');
  await Hive.openBox<Bus>('buses');
  await Hive.openBox<Driver>('drivers');
  await Hive.openBox<Prop>('props');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///we comunicate with boxes through the concorate classes : [HiveDatabase] and [Setting]

    ///settings class use for saving sttings of application
    ///like which theme is selected or which language user picked up
    final Settings settings = Settings(settingsBox: Hive.box('settings'));

    ///the main database of application
    ///use for saving main models of app : [Bus] , [Driver] and [Prop]
    ///in all across the app we have only one instance of this class
    ///provide it with [RepositoryProvider] to access anywhere just using a [BuildContext] instance
    ///ex :
    ///     Database database = context.read<Database>();
    ///     database.deleteDriver(...);
    ///     database.putProp(...);
    ///     .
    ///     .
    ///     .
    final Database database = HiveDatabase(
      buses: Hive.box('buses'),
      drivers: Hive.box('drivers'),
      props: Hive.box('props'),
    );

    return RepositoryProvider(
      ///provide a [Database] instance to using it all across the app with just a single instance
      create: (context) => database,
      child: MultiBlocProvider(
        ///provide main cubits of app : [LanguageCubit] and [ThemeCubit]
        ///we provide them higher than [MaterialApp] to access them anywhere in the app
        providers: [
          BlocProvider(
            create: (context) => LanguageCubit(
              settings: settings,
            ),
          ),
          BlocProvider(
            create: (context) => ThemeCubit(
              languageCubit: context.read<LanguageCubit>(),
              settings: settings,
            ),
          ),
        ],
        child: Builder(
          builder: (context) {
            return MaterialApp(
              home: MultiBlocProvider(
                ///provide cubits and blocs only for use in [HomePage]
                providers: [
                  BlocProvider(create: (context) => SearchBloc()),
                  BlocProvider(create: (context) => FilterTermsBloc()),
                  BlocProvider(
                    create: (context) => FilterPropCubit(
                      database: context.read<Database>(),
                      searchBloc: context.read<SearchBloc>(),
                      filterTermsBloc: context.read<FilterTermsBloc>(),
                    ),
                  ),
                ],
                child: const HomePage(),
              ),
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

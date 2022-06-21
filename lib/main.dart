import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:new_bus_information/cubit/language/language_cubit.dart';
import 'package:new_bus_information/cubit/theme/theme_cubit.dart';
import 'package:new_bus_information/generated/l10n.dart';
import 'package:new_bus_information/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => LanguageCubit()),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            home:const HomePage(),
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
    );
  }
}

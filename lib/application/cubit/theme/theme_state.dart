part of 'theme_cubit.dart';

abstract class ThemeState {
  static ThemeState of(BuildContext context) => BlocProvider.of<ThemeCubit>(context).state;

  ThemeData theme = ThemeData.dark();

  Color get onCard;

  Color get onTapSplash;

  Color get createDialog;

  Color get enableInputBorder;

  Color get errorInputBorder;

  Color get focusInputBorder;
}

class DarkThemeState extends ThemeState {
  @override
  ThemeData get theme => ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
        ),
        inputDecorationTheme: InputDecorationTheme(
          iconColor: enableInputBorder,
          floatingLabelStyle: TextStyle(
            color: enableInputBorder,
          ),
        ),
      );

  @override
  Color get onCard => Colors.white.withAlpha(250);

  @override
  Color get onTapSplash => Colors.black26;

  @override
  Color get createDialog => const Color(0xff343434);

  @override
  Color get enableInputBorder => Colors.white;

  @override
  Color get errorInputBorder => Colors.redAccent;

  @override
  Color get focusInputBorder => Colors.white;
}

class LightThemeState extends ThemeState {
  @override
  ThemeData get theme => ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white.withAlpha(245),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
        ),
        primaryIconTheme: const IconThemeData(color: Colors.black),
        inputDecorationTheme: InputDecorationTheme(
          iconColor: enableInputBorder,
          floatingLabelStyle: TextStyle(
            color: enableInputBorder,
          ),
        ),
      );

  @override
  Color get onCard => Colors.black54;

  @override
  Color get onTapSplash => Colors.black26;

  @override
  Color get createDialog => theme.primaryColorLight;

  @override
  Color get enableInputBorder => Colors.black;

  @override
  Color get errorInputBorder => Colors.redAccent;

  @override
  Color get focusInputBorder => Colors.black;
}

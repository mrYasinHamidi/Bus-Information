part of 'theme_cubit.dart';

abstract class ThemeState {
  static ThemeState of(BuildContext context) => BlocProvider.of<ThemeCubit>(context).state;

  ThemeData theme = ThemeData();

  Color get onCard;

  Color get onTapSplash;

  Color get createDialog;

  Color get enableInputBorder;

  Color get errorInputBorder;

  Color get focusInputBorder;

  Color get primaryColor;

  Color get secondaryColor;

  Color get scaffoldBackground;

  Color get cardColor;
}

class DarkThemeState extends ThemeState {
  final String? fontFamily;
  DarkThemeState({this.fontFamily});

  @override
  ThemeData get theme => ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: primaryColor,
        ),
        primaryColor: primaryColor,
        scaffoldBackgroundColor: scaffoldBackground,
        fontFamily: fontFamily,
        brightness: Brightness.dark,
        cardColor: cardColor,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: secondaryColor,
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
  Color get onTapSplash => const Color(0xff9e9e9e);

  @override
  Color get createDialog => const Color(0xff343434);

  @override
  Color get enableInputBorder => Colors.white;

  @override
  Color get errorInputBorder => Colors.redAccent;

  @override
  Color get focusInputBorder => Colors.white;

  @override
  Color get primaryColor => const Color(0xff212121);

  @override
  Color get secondaryColor => const Color(0xff00acc1);

  @override
  Color get scaffoldBackground => const Color(0xff373737);

  @override
  Color get cardColor => const Color(0xff272727);
}

class LightThemeState extends ThemeState {
  final String? fontFamily;
  LightThemeState({this.fontFamily});

  @override
  ThemeData get theme => ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: primaryColor,
        ),
        primaryIconTheme: const IconThemeData(color: Colors.black),
        primaryColor: primaryColor,
        fontFamily: fontFamily,
        cardColor: cardColor,
        brightness: Brightness.light,
        scaffoldBackgroundColor: scaffoldBackground,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: secondaryColor,
        ),
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

  @override
  Color get primaryColor => const Color(0xffc49000);

  @override
  Color get secondaryColor => const Color(0xfffbc02d);

  @override
  Color get scaffoldBackground => const Color(0xffffffff);

  @override
  Color get cardColor => const Color(0xff383838);
}

part of 'theme_cubit.dart';

abstract class ThemeState {
  static ThemeState of(BuildContext context) => BlocProvider.of<ThemeCubit>(context).state;

  ThemeData theme = ThemeData();

  TextStyle get smokeTitleLarge;
  Color get onTapSplash;

  Color get createDialog;
}

class DarkThemeState extends ThemeState {
  final String? fontFamily;
  DarkThemeState({this.fontFamily});

  @override
  ThemeData get theme => ThemeData(
        fontFamily: fontFamily,
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: Colors.orange,
          onPrimary: Colors.white,
          secondary: Colors.orange,
          onSecondary: Colors.white,
          error: Colors.redAccent,
          onError: Colors.white,
          background: Colors.green,
          onBackground: Colors.white,
          surface: Color(0xff212121),
          onSurface: Colors.white,
        ),
        // inputDecorationTheme: InputDecorationTheme(
        // iconColor: enableInputBorder,
        // floatingLabelStyle: TextStyle(
        // color: enableInputBorder,
        // ),
        // ),
      );

  @override
  Color get onTapSplash => const Color(0xff9e9e9e);

  @override
  Color get createDialog => const Color(0xff343434);

  @override
  TextStyle get smokeTitleLarge => const TextStyle(
        color: Colors.white24,
        fontSize: 26,
      );
}

class LightThemeState extends ThemeState {
  final String? fontFamily;
  LightThemeState({this.fontFamily});

  @override
  ThemeData get theme => ThemeData(
        fontFamily: fontFamily,
        // primaryColor: Colors.yellow,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.green,
          onPrimary: Colors.white,
          secondary: Colors.blueAccent,
          onSecondary: Colors.white,
          error: Colors.redAccent,
          onError: Colors.white,
          background: Colors.lightGreen,
          onBackground: Colors.white,
          surface: Color(0xff212121),
          onSurface: Colors.white,
        ),

        // inputDecorationTheme: InputDecorationTheme(
        // iconColor: enableInputBorder,
        // floatingLabelStyle: TextStyle(
        // color: enableInputBorder,
        // ),
        // ),
      );

  @override
  Color get onTapSplash => Colors.black26;

  @override
  Color get createDialog => theme.primaryColorLight;

  @override
  TextStyle get smokeTitleLarge => const TextStyle(
        color: Colors.black26,
        fontSize: 26,
      );
}

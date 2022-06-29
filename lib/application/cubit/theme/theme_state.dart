part of 'theme_cubit.dart';

abstract class ThemeState {
  static ThemeState of(BuildContext context) => BlocProvider.of<ThemeCubit>(context).state;

  ThemeData theme = ThemeData.dark();

  Color get onCard;

  Color get onTapSplash;

  Color get createDialog;
}

class DarkThemeState extends ThemeState {
  @override
  ThemeData get theme => ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
        ),
      );

  @override
  Color get onCard => Colors.white.withAlpha(250);

  @override
  Color get onTapSplash => Colors.black26;

  @override
  Color get createDialog => theme.primaryColor;//const Color(0xff4b4b4b);
}

class LightThemeState extends ThemeState {
  @override
  ThemeData get theme => ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white.withAlpha(245),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
        ),
        primaryIconTheme: const IconThemeData(color: Colors.black),
      );

  @override
  Color get onCard => Colors.black54;

  @override
  Color get onTapSplash => Colors.black26;


  @override
  Color get createDialog => Colors.lightBlueAccent;
}

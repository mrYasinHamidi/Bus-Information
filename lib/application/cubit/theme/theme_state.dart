part of 'theme_cubit.dart';

abstract class ThemeState {
  ThemeData theme = ThemeData.dark();
}

class DarkThemeState extends ThemeState {
  @override
  ThemeData get theme => ThemeData.dark().copyWith();
}

class LightThemeState extends ThemeState {
  @override
  ThemeData get theme => ThemeData.light().copyWith();
}

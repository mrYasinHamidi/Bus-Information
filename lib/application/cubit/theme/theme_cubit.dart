import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bus_information/application/cubit/language/language_cubit.dart';
import 'package:new_bus_information/application/cubit/settings/settings_cubit.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final LanguageCubit languageCubit;
  final Settings settings;
  late StreamSubscription languageSubscription;
  ThemeCubit({required this.languageCubit, required this.settings})
      : super(
          settings.isLight
              ? LightThemeState(fontFamily: languageCubit.state.fontFamily)
              : DarkThemeState(fontFamily: languageCubit.state.fontFamily),
        ) {
    languageSubscription = languageCubit.stream.listen((event) {
      _reBuild();
    });
  }

  void _reBuild() {
    late ThemeState newState;
    if (state is LightThemeState) {
      newState = LightThemeState(fontFamily: languageCubit.state.fontFamily);
    } else if (state is DarkThemeState) {
      newState = DarkThemeState(fontFamily: languageCubit.state.fontFamily);
    }
    emit(newState);
  }

  void toggleTheme() {
    switch (state.runtimeType) {
      case LightThemeState:
        emit(DarkThemeState(fontFamily: languageCubit.state.fontFamily));
        break;
      case DarkThemeState:
        emit(LightThemeState(fontFamily: languageCubit.state.fontFamily));
        break;
    }

    ///save the changes in [Settings]
    settings.isLight = state is LightThemeState;
  }

  @override
  Future<void> close() {
    languageSubscription.cancel();
    return super.close();
  }
}

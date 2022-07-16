import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bus_information/application/cubit/language/language_cubit.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final LanguageCubit languageCubit;
  late StreamSubscription languageSubscription;
  ThemeCubit({required this.languageCubit}) : super(DarkThemeState(fontFamily: languageCubit.state.fontFamily)) {
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
  }

  @override
  Future<void> close() {
    languageSubscription.cancel();
    return super.close();
  }
}

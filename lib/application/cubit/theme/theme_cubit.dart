import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(DarkThemeState());

  void toggleTheme() {
    switch (state.runtimeType) {
      case LightThemeState:
        emit(DarkThemeState());
        break;
      case DarkThemeState:
        emit(LightThemeState());
        break;
    }
  }
}

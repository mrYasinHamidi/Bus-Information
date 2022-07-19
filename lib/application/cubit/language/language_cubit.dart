import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(EnglishState());

  void toggleLanguage() {
    switch (state.runtimeType) {
      case EnglishState:
        emit(PersianState());
        break;
      case PersianState:
        emit(EnglishState());
        break;
    }
  }
}

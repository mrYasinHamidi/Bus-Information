import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:new_bus_information/application/cubit/settings/settings_cubit.dart';
part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final Settings settings;
  LanguageCubit({required this.settings})
      : super(
          settings.isEnglish ? EnglishState() : PersianState(),
        );

  void toggleLanguage() {
    switch (state.runtimeType) {
      case EnglishState:
        emit(PersianState());
        break;
      case PersianState:
        emit(EnglishState());
        break;
    }

    ///save the changes in [Settings]
    settings.isEnglish = state is EnglishState;
  }
}

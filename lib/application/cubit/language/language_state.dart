part of 'language_cubit.dart';

abstract class LanguageState {
  Locale locale = const Locale('en');
  String fontFamily = '';
}

class EnglishState extends LanguageState {
  @override
  Locale get locale => const Locale('en');

  @override
  String get fontFamily => 'englishFont';
}

class PersianState extends LanguageState {
  @override
  Locale get locale => const Locale('fa');

  @override
  String get fontFamily => 'iranSans';
}

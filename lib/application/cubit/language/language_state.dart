part of 'language_cubit.dart';

abstract class LanguageState {
  Locale locale = const Locale('en');
}

class EnglishState extends LanguageState {
  @override
  Locale get locale => const Locale('en');
}

class PersianState extends LanguageState {
  @override
  Locale get locale => const Locale('fa');
}

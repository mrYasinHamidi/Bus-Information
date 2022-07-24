// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final bool isLight;
  final bool isEnglish;

  const SettingsState({required this.isEnglish, required this.isLight});
  factory SettingsState.initial() {
    return const SettingsState(isEnglish: false, isLight: false);
  }
  @override
  List<Object> get props => [isLight, isEnglish];

  SettingsState copyWith({
    bool? isLight,
    bool? isEnglish,
  }) {
    return SettingsState(
      isLight: isLight ?? this.isLight,
      isEnglish: isEnglish ?? this.isEnglish,
    );
  }
}

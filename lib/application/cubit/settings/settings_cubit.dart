import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:new_bus_information/application/database/database_error.dart';

part 'settings_state.dart';

class Settings {
  bool _isLight = false;
  bool get isLight => _isLight;
  set isLight(bool value) {
    if (value == _isLight) return;
    _requireInitialized();
    settingsBox.put('isLight', value);
    _isLight = value;
  }

  bool _isEnglish = false;
  bool get isEnglish => _isEnglish;
  set isEnglish(bool value) {
    if (value == _isEnglish) return;
    _requireInitialized();
    settingsBox.put('isEnglish', value);
    _isEnglish = value;
  }

  Box<bool> settingsBox;

  Settings({required this.settingsBox}) {
    _getData();
  }

  void _getData() {
    _requireInitialized();
    _isEnglish = settingsBox.get('isEnglish') ?? false;
    _isLight = settingsBox.get('isLight') ?? false;
  }

  void _requireInitialized() {
    if (!Hive.isBoxOpen(settingsBox.name)) {
      throw DatabaseError('${settingsBox.name} used before initialize');
    }
  }
}

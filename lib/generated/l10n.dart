// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Bus Information`
  String get appName {
    return Intl.message(
      'Bus Information',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Toggle Language`
  String get toggleLanguage {
    return Intl.message(
      'Toggle Language',
      name: 'toggleLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Bus Number`
  String get busNumber {
    return Intl.message(
      'Bus Number',
      name: 'busNumber',
      desc: '',
      args: [],
    );
  }

  /// `Bus Status`
  String get busStatus {
    return Intl.message(
      'Bus Status',
      name: 'busStatus',
      desc: '',
      args: [],
    );
  }

  /// `Driver`
  String get driver {
    return Intl.message(
      'Driver',
      name: 'driver',
      desc: '',
      args: [],
    );
  }

  /// `Bus`
  String get bus {
    return Intl.message(
      'Bus',
      name: 'bus',
      desc: '',
      args: [],
    );
  }

  /// `Alternative`
  String get alternativeDriver {
    return Intl.message(
      'Alternative',
      name: 'alternativeDriver',
      desc: '',
      args: [],
    );
  }

  /// `Create Prop`
  String get createProp {
    return Intl.message(
      'Create Prop',
      name: 'createProp',
      desc: '',
      args: [],
    );
  }

  /// `Drivers`
  String get drivers {
    return Intl.message(
      'Drivers',
      name: 'drivers',
      desc: '',
      args: [],
    );
  }

  /// `Buses`
  String get buses {
    return Intl.message(
      'Buses',
      name: 'buses',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Should not empty`
  String get shouldNotEmpty {
    return Intl.message(
      'Should not empty',
      name: 'shouldNotEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Repeated number`
  String get repeatedNumber {
    return Intl.message(
      'Repeated number',
      name: 'repeatedNumber',
      desc: '',
      args: [],
    );
  }

  /// `Shift Work`
  String get shiftWork {
    return Intl.message(
      'Shift Work',
      name: 'shiftWork',
      desc: '',
      args: [],
    );
  }

  /// `driver Status`
  String get driverStatus {
    return Intl.message(
      'driver Status',
      name: 'driverStatus',
      desc: '',
      args: [],
    );
  }

  /// `Repeated Name`
  String get repeatedName {
    return Intl.message(
      'Repeated Name',
      name: 'repeatedName',
      desc: '',
      args: [],
    );
  }

  /// `Coordination`
  String get coordination {
    return Intl.message(
      'Coordination',
      name: 'coordination',
      desc: '',
      args: [],
    );
  }

  /// `Vacation`
  String get vacation {
    return Intl.message(
      'Vacation',
      name: 'vacation',
      desc: '',
      args: [],
    );
  }

  /// `Inactive`
  String get inActive {
    return Intl.message(
      'Inactive',
      name: 'inActive',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message(
      'Active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `Morning Shift`
  String get morningShift {
    return Intl.message(
      'Morning Shift',
      name: 'morningShift',
      desc: '',
      args: [],
    );
  }

  /// `Evening Shift`
  String get eveningShift {
    return Intl.message(
      'Evening Shift',
      name: 'eveningShift',
      desc: '',
      args: [],
    );
  }

  /// `First OverTime`
  String get firstOverTime {
    return Intl.message(
      'First OverTime',
      name: 'firstOverTime',
      desc: '',
      args: [],
    );
  }

  /// `Second OverTime`
  String get secondOverTime {
    return Intl.message(
      'Second OverTime',
      name: 'secondOverTime',
      desc: '',
      args: [],
    );
  }

  /// `Shift Switching`
  String get shiftSwitching {
    return Intl.message(
      'Shift Switching',
      name: 'shiftSwitching',
      desc: '',
      args: [],
    );
  }

  /// `Props`
  String get props {
    return Intl.message(
      'Props',
      name: 'props',
      desc: '',
      args: [],
    );
  }

  /// `Edite`
  String get edite {
    return Intl.message(
      'Edite',
      name: 'edite',
      desc: '',
      args: [],
    );
  }

  /// `Search Your Text here . . .`
  String get searchHint {
    return Intl.message(
      'Search Your Text here . . .',
      name: 'searchHint',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message(
      'From',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `Search On`
  String get searchOn {
    return Intl.message(
      'Search On',
      name: 'searchOn',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fa'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

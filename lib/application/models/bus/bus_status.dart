import 'package:flutter/material.dart';

enum BusStatus { active, deActive, }

extension BusStatusEx on BusStatus {
  String get text {
    switch (this) {
      case BusStatus.active:
        return 'Languages.language.value.active';
      case BusStatus.deActive:
        return 'Languages.language.value.inActive';
    }
  }
  Color get color {
    switch (this) {
      case BusStatus.active:
        return Colors.green;
      case BusStatus.deActive:
        return Colors.red;
    }
  }
}

extension BusStatusExe on List<BusStatus> {
  List<Text> get asTextList => map((e) => Text(e.text)).toList();
}
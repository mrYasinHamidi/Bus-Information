import 'package:new_bus_information/generated/l10n.dart';

enum SearchCondidateType { bus, firstDriver, secondDriver }

extension CondidateExtension on SearchCondidateType {
  String get text {
    switch (this) {
      case SearchCondidateType.bus:
        return S.current.bus;
      case SearchCondidateType.firstDriver:
        return S.current.driver;
      case SearchCondidateType.secondDriver:
        return S.current.alternativeDriver;
    }
  }
}

part of 'bus.dart';

extension BusListExtension on List<Bus> {
  void reSort() {
    sort(
      (a, b) => b.getCreationTime().compareTo(a.getCreationTime()),
    );
  }
}

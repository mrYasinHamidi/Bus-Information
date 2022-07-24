part of 'driver.dart';

extension DriverListExtension on List<Driver> {
  reSort() {
    sort(
      (a, b) => b.getCreationTime().compareTo(a.getCreationTime()),
    );
  }
}

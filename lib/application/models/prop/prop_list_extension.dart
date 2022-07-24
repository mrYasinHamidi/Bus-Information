part of 'prop.dart';

extension PropListExtension on List<Prop> {
  void reSort() {
    sort(
      (a, b) => b.getCreationTime().compareTo(a.getCreationTime()),
    );
  }
}

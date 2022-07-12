// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'object_list_cubit.dart';

class ObjectListState<T extends BaseObject> extends Equatable {
  final List<T> objects;
  const ObjectListState({required this.objects});

  @override
  List<Object> get props => [objects];

  ObjectListState<T> copyWith({
    List<T>? objects,
  }) {
    return ObjectListState<T>(
      objects: objects ?? this.objects,
    );
  }
}

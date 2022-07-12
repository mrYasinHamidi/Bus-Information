// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'object_list_cubit.dart';

class ObjectListState extends Equatable {
  final List<BaseObject> objects;
  const ObjectListState({required this.objects});

  @override
  List<Object> get props => [objects];

  ObjectListState copyWith({
    List<BaseObject>? objects,
  }) {
    return ObjectListState(
      objects: objects ?? this.objects,
    );
  }
}

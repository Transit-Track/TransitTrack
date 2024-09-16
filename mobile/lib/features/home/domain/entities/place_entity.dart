import 'package:equatable/equatable.dart';

class PlaceEntity extends Equatable {
  final String id;
  final String name;

  const PlaceEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}

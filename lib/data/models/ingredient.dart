import 'package:equatable/equatable.dart';

// 1
class Ingredient extends Equatable {
  // 2
  int? id;
  int? recipeId;
  final String? name;
  final double? weight;

  // 3
  Ingredient({this.id, this.recipeId, this.name, this.weight});

  // Equatable use props to to check quality.
  // Here we check equality with these 3 values.
  @override
  List<Object?> get props => [recipeId, name, weight];
}

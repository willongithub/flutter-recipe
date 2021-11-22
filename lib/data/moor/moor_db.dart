// import 'package:moor_flutter/moor_flutter.dart';
// import '../models/models.dart';

// part 'moor_db.g.dart';

// // This definition is a bit unusual. You first define the column type with type
// // classes that handle different types:
// //   IntColumn: Integers.
// //   BoolColumn: Booleans.
// //   TextColumn: Text.
// //   DateTimeColumn: Dates.
// //   RealColumn: Doubles.
// //   BlobColumn: Arbitrary blobs of data.
// // It also uses a “double” method call, where each call returns a builder.
// // For example, to create IntColumn, you need to make a final call with the extra () to create it.
// class MoorRecipe extends Table {
//   // 2
//   IntColumn get id => integer().autoIncrement()();

//   // 3
//   TextColumn get label => text()();

//   TextColumn get image => text()();

//   TextColumn get url => text()();

//   RealColumn get calories => real()();

//   RealColumn get totalWeight => real()();

//   RealColumn get totalTime => real()();
// }

// class MoorIngredient extends Table {
//   IntColumn get id => integer().autoIncrement()();

//   IntColumn get recipeId => integer()();

//   TextColumn get name => text()();

//   RealColumn get weight => real()();
// }

// // 1
// @UseMoor(tables: [MoorRecipe, MoorIngredient], daos: [RecipeDao, IngredientDao])
// // 2
// class RecipeDatabase extends _$RecipeDatabase {
//   RecipeDatabase()
//       // 3
//       : super(FlutterQueryExecutor.inDatabaseFolder(
//             path: 'recipes.sqlite', logStatements: true));

//   // 4
//   @override
//   int get schemaVersion => 1;
// }

// // 1
// @UseDao(tables: [MoorRecipe])
// // 2
// class RecipeDao extends DatabaseAccessor<RecipeDatabase> with _$RecipeDaoMixin {
//   // 3
//   final RecipeDatabase db;

//   RecipeDao(this.db) : super(db);

//   // 4
//   Future<List<MoorRecipeData>> findAllRecipes() => select(moorRecipe).get();

//   // 5
//   Stream<List<Recipe>> watchAllRecipes() {
//     // 1
//     return select(moorRecipe)
//         // 2
//         .watch()
//         // 3
//         .map(
//       (rows) {
//         final recipes = <Recipe>[];
//         // 4
//         rows.forEach(
//           (row) {
//             // 5
//             final recipe = moorRecipeToRecipe(row);
//             // 6
//             if (!recipes.contains(recipe)) {
//               recipe.ingredients = <Ingredient>[];
//               recipes.add(recipe);
//             }
//           },
//         );
//         return recipes;
//       },
//     );
//   }

//   // 6
//   Future<List<MoorRecipeData>> findRecipeById(int id) =>
//       (select(moorRecipe)..where((tbl) => tbl.id.equals(id))).get();

//   // 7
//   Future<int> insertRecipe(Insertable<MoorRecipeData> recipe) =>
//       into(moorRecipe).insert(recipe);

//   // 8
//   Future deleteRecipe(int id) => Future.value(
//       (delete(moorRecipe)..where((tbl) => tbl.id.equals(id))).go());
// }

// // 1
// @UseDao(tables: [MoorIngredient])
// // 2
// class IngredientDao extends DatabaseAccessor<RecipeDatabase>
//     with _$IngredientDaoMixin {
//   final RecipeDatabase db;

//   IngredientDao(this.db) : super(db);

//   Future<List<MoorIngredientData>> findAllIngredients() =>
//       select(moorIngredient).get();

//   // 3
//   Stream<List<MoorIngredientData>> watchAllIngredients() =>
//       select(moorIngredient).watch();

//   // 4
//   Future<List<MoorIngredientData>> findRecipeIngredients(int id) =>
//       (select(moorIngredient)..where((tbl) => tbl.recipeId.equals(id))).get();

//   // 5
//   Future<int> insertIngredient(Insertable<MoorIngredientData> ingredient) =>
//       into(moorIngredient).insert(ingredient);

//   // 6
//   Future deleteIngredient(int id) => Future.value(
//       (delete(moorIngredient)..where((tbl) => tbl.id.equals(id))).go());
// }

// // Conversion Methods
// Recipe moorRecipeToRecipe(MoorRecipeData recipe) {
//   return Recipe(
//       id: recipe.id,
//       label: recipe.label,
//       image: recipe.image,
//       url: recipe.url,
//       calories: recipe.calories,
//       totalWeight: recipe.totalWeight,
//       totalTime: recipe.totalTime);
// }

// Insertable<MoorRecipeData> recipeToInsertableMoorRecipe(Recipe recipe) {
//   return MoorRecipeCompanion.insert(
//       label: recipe.label ?? '',
//       image: recipe.image ?? '',
//       url: recipe.url ?? '',
//       calories: recipe.calories ?? 0,
//       totalWeight: recipe.totalWeight ?? 0,
//       totalTime: recipe.totalTime ?? 0);
// }

// Ingredient moorIngredientToIngredient(MoorIngredientData ingredient) {
//   return Ingredient(
//       id: ingredient.id,
//       recipeId: ingredient.recipeId,
//       name: ingredient.name,
//       weight: ingredient.weight);
// }

// MoorIngredientCompanion ingredientToInsertableMoorIngredient(
//     Ingredient ingredient) {
//   return MoorIngredientCompanion.insert(
//       recipeId: ingredient.recipeId ?? 0,
//       name: ingredient.name ?? '',
//       weight: ingredient.weight ?? 0);
// }

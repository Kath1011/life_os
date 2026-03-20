import 'package:flutter_riverpod/flutter_riverpod.dart';

class Recipe {
  const Recipe({
    required this.id,
    required this.title,
    required this.requiredIngredients,
  });

  final String id;
  final String title;
  final Set<String> requiredIngredients;
}

class RecipeRepository {
  const RecipeRepository();

  static const List<Recipe> _recipes = [
    Recipe(
      id: 'rice_eggs',
      title: 'Garlic Egg Fried Rice',
      requiredIngredients: {'Rice', 'Eggs', 'Onion'},
    ),
    Recipe(
      id: 'stew',
      title: 'Tomato Bean Stew',
      requiredIngredients: {'Tomato', 'Beans', 'Onion'},
    ),
    Recipe(
      id: 'chicken_skillet',
      title: 'One-Pan Chicken Skillet',
      requiredIngredients: {'Chicken', 'Tomato', 'Onion'},
    ),
  ];

  List<Recipe> match(Set<String> ingredients) {
    if (ingredients.isEmpty) {
      return const <Recipe>[];
    }

    return _recipes
        .where((recipe) {
          return recipe.requiredIngredients.every(ingredients.contains);
        })
        .toList(growable: false);
  }
}

final recipeRepositoryProvider = Provider<RecipeRepository>((ref) {
  return const RecipeRepository();
});

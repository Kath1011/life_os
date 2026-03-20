import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_os/services/lifeos_controller.dart';

class UtilitiesTab extends ConsumerWidget {
  const UtilitiesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIngredients = ref.watch(
      lifeOsControllerProvider.select((s) => s.selectedIngredients),
    );
    final matchedRecipes = ref.watch(matchedRecipesProvider);
    final controller = ref.read(lifeOsControllerProvider.notifier);

    const ingredients = ['Rice', 'Beans', 'Tomato', 'Eggs', 'Chicken', 'Onion'];
    const template =
        'Subject: Request for urgent repair support\n\nDear Building Admin,\nPlease schedule a maintenance visit for the ceiling leak at Unit 4B.\n\nRegards,\nAlex';

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Pantry Matcher',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ingredients.map((item) {
            final selected = selectedIngredients.contains(item);
            return FilterChip(
              selected: selected,
              label: Text(item),
              onSelected: (_) => controller.toggleIngredient(item),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.search),
          label: const Text('Find Matching Recipes'),
        ),
        const SizedBox(height: 8),
        if (matchedRecipes.isNotEmpty)
          ...matchedRecipes.map(
            (recipe) => ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: Text(recipe.title),
              subtitle: Text(recipe.requiredIngredients.join(', ')),
            ),
          )
        else
          const Text('No recipe match yet. Select more pantry ingredients.'),
        const SizedBox(height: 22),
        const Text(
          'Formal Templates',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF161B22),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(template),
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: () async {
            await Clipboard.setData(const ClipboardData(text: template));
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Template copied to clipboard')),
              );
            }
          },
          icon: const Icon(Icons.copy),
          label: const Text('Copy to Clipboard'),
        ),
      ],
    );
  }
}

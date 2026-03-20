import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UtilitiesTab extends StatelessWidget {
  const UtilitiesTab({
    super.key,
    required this.selectedIngredients,
    required this.onIngredientToggle,
  });

  final Set<String> selectedIngredients;
  final ValueChanged<String> onIngredientToggle;

  @override
  Widget build(BuildContext context) {
    const ingredients = ['Rice', 'Beans', 'Tomato', 'Eggs', 'Chicken', 'Onion'];
    const template =
        'Subject: Request for urgent repair support\n\nDear Building Admin,\nPlease schedule a maintenance visit for the ceiling leak at Unit 4B.\n\nRegards,\nAlex';

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Pantry Matcher', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ingredients.map((item) {
            final selected = selectedIngredients.contains(item);
            return FilterChip(
              selected: selected,
              label: Text(item),
              onSelected: (_) => onIngredientToggle(item),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.search),
          label: const Text('Find Matching Recipes'),
        ),
        const SizedBox(height: 22),
        const Text('Formal Templates', style: TextStyle(fontWeight: FontWeight.bold)),
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

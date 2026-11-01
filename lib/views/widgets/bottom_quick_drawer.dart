import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/furniture_provider.dart';

class BottomQuickDrawer extends StatelessWidget {
  const BottomQuickDrawer({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const BottomQuickDrawer(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final furnitureProv = context.watch<FurnitureProvider>();

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Quick Filter & Sort',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'Categories',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: furnitureProv.categories.map((cat) {
              final isSelected = furnitureProv.selectedCategory == cat;
              return ChoiceChip(
                label: Text(cat),
                selected: isSelected,
                selectedColor: const Color(0xFF2C3E50),
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                onSelected: (_) {
                  furnitureProv.selectCategory(cat);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2C3E50),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Apply Filters', style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ],
      ),
    );
  }
}

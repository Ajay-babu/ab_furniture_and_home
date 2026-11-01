import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/furniture_provider.dart';
import 'widgets/animated_banner_slideshow.dart';
import 'widgets/furniture_card.dart';
import '../widgets/bottom_quick_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final furnitureProv = context.watch<FurnitureProvider>();
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // Search & Filter Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (val) => furnitureProv.updateSearchQuery(val),
                      decoration: InputDecoration(
                        hintText: 'Search sofa, chair, bed, table...',
                        prefixIcon: const Icon(Icons.search, color: Color(0xFF2C3E50)),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C3E50),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.tune, color: Colors.white),
                      onPressed: () => BottomQuickDrawer.show(context),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Horizontal Advertisement Slideshow
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: AnimatedBannerSlideshow(),
            ),
          ),

          // Horizontal Category Filter Bar
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: furnitureProv.categories.length,
                itemBuilder: (context, index) {
                  final cat = furnitureProv.categories[index];
                  final isSelected = furnitureProv.selectedCategory == cat;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: isSelected,
                      selectedColor: const Color(0xFF2C3E50),
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      onSelected: (_) {
                        furnitureProv.selectCategory(cat);
                      },
                    ),
                  );
                },
              ),
            ),
          ),

          // Furniture Grid Section Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${furnitureProv.selectedCategory} Collection',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${furnitureProv.filteredItems.length} items',
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),

          // Furniture Grid Items
          furnitureProv.filteredItems.isEmpty
              ? const SliverFillRemaining(
                  child: Center(
                    child: Text('No furniture items found matching criteria.'),
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.72,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final item = furnitureProv.filteredItems[index];
                        return FurnitureCard(item: item);
                      },
                      childCount: furnitureProv.filteredItems.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

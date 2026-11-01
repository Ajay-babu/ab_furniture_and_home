import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/furniture_item.dart';
import '../../providers/cart_provider.dart';
import '../../providers/furniture_provider.dart';

class FurnitureDetailScreen extends StatefulWidget {
  final FurnitureItem item;
  const FurnitureDetailScreen({super.key, required this.item});

  @override
  State<FurnitureDetailScreen> createState() => _FurnitureDetailScreenState();
}

class _FurnitureDetailScreenState extends State<FurnitureDetailScreen> {
  int _quantity = 1;
  late String _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.item.availableColors.isNotEmpty
        ? widget.item.availableColors.first
        : '#333333';
  }

  Color _parseHexColor(String hexString) {
    try {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (_) {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProv = context.watch<CartProvider>();
    final furnitureProv = context.watch<FurnitureProvider>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Sliver App Bar with Hero Image (Asset / Network)
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            backgroundColor: const Color(0xFF2C3E50),
            leading: CircleAvatar(
              backgroundColor: Colors.white.withValues(alpha: 0.8),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black87),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            actions: [
              CircleAvatar(
                backgroundColor: Colors.white.withValues(alpha: 0.8),
                child: IconButton(
                  icon: Icon(
                    widget.item.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: widget.item.isFavorite ? Colors.redAccent : Colors.black87,
                  ),
                  onPressed: () {
                    furnitureProv.toggleFavorite(widget.item.id);
                    setState(() {
                      widget.item.isFavorite = !widget.item.isFavorite;
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'furniture_img_${widget.item.id}',
                child: widget.item.imageUrl.startsWith('assets/')
                    ? Image.asset(
                        widget.item.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.chair, size: 80, color: Colors.grey),
                        ),
                      )
                    : Image.network(
                        widget.item.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.chair, size: 80, color: Colors.grey),
                        ),
                      ),
              ),
            ),
          ),

          // Content Details
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Rating Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.item.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.item.rating}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Category: ${widget.item.category}',
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 16),

                  // Price and Quantity Selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹${widget.item.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton.filledTonal(
                            onPressed: _quantity > 1
                                ? () => setState(() => _quantity--)
                                : null,
                            icon: const Icon(Icons.remove),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              '$_quantity',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton.filledTonal(
                            onPressed: () => setState(() => _quantity++),
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(height: 32),

                  // Available Colors Selection
                  const Text(
                    'Color Option',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: widget.item.availableColors.map((hexColor) {
                      final isSelected = _selectedColor == hexColor;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedColor = hexColor),
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? const Color(0xFF2C3E50) : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: _parseHexColor(hexColor),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.item.description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.5),
                  ),
                  const SizedBox(height: 20),

                  // Specifications Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Product Specifications',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(Icons.straighten, size: 20, color: Color(0xFF2C3E50)),
                            const SizedBox(width: 8),
                            Text('Dimensions: ${widget.item.dimensions}'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.construction, size: 20, color: Color(0xFF2C3E50)),
                            const SizedBox(width: 8),
                            Text('Material: ${widget.item.material}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom Add to Cart Bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: SafeArea(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2C3E50),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {
              cartProv.addToCart(
                widget.item,
                quantity: _quantity,
                selectedColor: _selectedColor,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added ${widget.item.name} x$_quantity to Cart!'),
                  action: SnackBarAction(
                    label: 'VIEW CART',
                    textColor: Colors.amber,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_outlined, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Add to Cart',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

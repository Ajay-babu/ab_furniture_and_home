import 'furniture_item.dart';

class CartItem {
  final FurnitureItem item;
  int quantity;
  String selectedColor;

  CartItem({
    required this.item,
    this.quantity = 1,
    required this.selectedColor,
  });

  double get totalPrice => item.price * quantity;
}

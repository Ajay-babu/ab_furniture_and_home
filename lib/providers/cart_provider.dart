import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/furniture_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => List.unmodifiable(_cartItems);

  int get totalItemCount =>
      _cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  double get taxAmount => subtotal * 0.18; // 18% GST

  double get deliveryFee => _cartItems.isEmpty ? 0.0 : (subtotal > 20000 ? 0.0 : 499.0);

  double get grandTotal => subtotal + taxAmount + deliveryFee;

  void addToCart(FurnitureItem item, {int quantity = 1, String? selectedColor}) {
    final color = selectedColor ?? (item.availableColors.isNotEmpty ? item.availableColors.first : '#333333');
    final existingIndex = _cartItems.indexWhere(
        (ci) => ci.item.id == item.id && ci.selectedColor == color);

    if (existingIndex >= 0) {
      _cartItems[existingIndex].quantity += quantity;
    } else {
      _cartItems.add(
        CartItem(item: item, quantity: quantity, selectedColor: color),
      );
    }
    notifyListeners();
  }

  void updateQuantity(String itemId, String color, int newQuantity) {
    final index = _cartItems.indexWhere(
        (ci) => ci.item.id == itemId && ci.selectedColor == color);
    if (index >= 0) {
      if (newQuantity <= 0) {
        _cartItems.removeAt(index);
      } else {
        _cartItems[index].quantity = newQuantity;
      }
      notifyListeners();
    }
  }

  void removeFromCart(String itemId, String color) {
    _cartItems.removeWhere(
        (ci) => ci.item.id == itemId && ci.selectedColor == color);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}

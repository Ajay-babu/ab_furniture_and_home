import 'package:flutter/material.dart';
import '../models/furniture_item.dart';

class FurnitureProvider extends ChangeNotifier {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  List<FurnitureItem> _items = [];

  FurnitureProvider() {
    _loadSampleFurnitureData();
  }

  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  final List<String> categories = [
    'All',
    'Sofa',
    'Chair',
    'Table',
    'Bed',
    'Decor',
  ];

  List<FurnitureItem> get filteredItems {
    return _items.where((item) {
      final matchesCategory = _selectedCategory == 'All' ||
          item.category.toLowerCase() == _selectedCategory.toLowerCase();
      final matchesSearch = item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.description.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  List<FurnitureItem> get favoriteItems =>
      _items.where((item) => item.isFavorite).toList();

  List<FurnitureItem> get popularItems =>
      _items.where((item) => item.isPopular).toList();

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void toggleFavorite(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      _items[index].isFavorite = !_items[index].isFavorite;
      notifyListeners();
    }
  }

  void _loadSampleFurnitureData() {
    _items = [
      FurnitureItem(
        id: 'f1',
        name: 'Single Seater Sofa Chair',
        category: 'Chair',
        price: 12999.00,
        rating: 4.8,
        description:
            'Crafted with premium ergonomic cushioning and durable inner frame. Perfect for modern living rooms and reading corners.',
        imageUrl: 'assets/images/single_seater_sofa_chair.jpeg',
        material: 'Solid Wood & Breathable Fabric',
        dimensions: '75 cm x 80 cm x 85 cm',
        availableColors: ['#8D6E63', '#37474F', '#D7CCC8'],
        isPopular: true,
        isFavorite: true,
      ),
      FurnitureItem(
        id: 'f2',
        name: 'Modern Curve Sofa',
        category: 'Sofa',
        price: 38999.00,
        rating: 4.9,
        description:
            'Luxury curved sofa wrapped in soft, high-grade upholstery. Adds aesthetic elegance and supreme seating comfort to any room.',
        imageUrl: 'assets/images/curve_sofa.jpeg',
        material: 'Premium Velvet & Teakwood Base',
        dimensions: '220 cm x 95 cm x 85 cm',
        availableColors: ['#1B5E20', '#0D47A1', '#424242'],
        isPopular: true,
      ),
      FurnitureItem(
        id: 'f3',
        name: 'Luxury 5-Seater Sofa Set',
        category: 'Sofa',
        price: 49500.00,
        rating: 4.9,
        description:
            'Spacious 5-seater sectional sofa set designed for family comfort and grand living rooms.',
        imageUrl: 'assets/images/five_seater_sofa.jpeg',
        material: 'High-Density Foam & Hardwood Frame',
        dimensions: '280 cm x 180 cm x 85 cm',
        availableColors: ['#3E2723', '#212121'],
        isPopular: true,
      ),
      FurnitureItem(
        id: 'f4',
        name: 'Classic Couch Sofa',
        category: 'Sofa',
        price: 27999.00,
        rating: 4.7,
        description:
            'Timeless couch design with plush deep seating and plush back pillows for daily relaxation.',
        imageUrl: 'assets/images/cauch_sofa.jpeg',
        material: 'Soft Linen & Solid Oak',
        dimensions: '190 cm x 85 cm x 80 cm',
        availableColors: ['#BDBDBD', '#3E2723'],
        isPopular: false,
      ),
      FurnitureItem(
        id: 'f5',
        name: 'Compact Curved Accent Sofa',
        category: 'Sofa',
        price: 21999.00,
        rating: 4.6,
        description:
            'Sleek compact curved sofa tailored for smaller apartments, study rooms, or lounge spaces.',
        imageUrl: 'assets/images/small_curve_sofa.jpeg',
        material: 'Microfiber Fabric & Steel Legs',
        dimensions: '150 cm x 75 cm x 80 cm',
        availableColors: ['#FFD54F', '#212121'],
        isPopular: false,
      ),
      FurnitureItem(
        id: 'f6',
        name: 'Executive Sofa Chairs Pair',
        category: 'Chair',
        price: 18499.00,
        rating: 4.8,
        description:
            'Set of premium accent sofa chairs crafted for office waiting lounges, living rooms, or executive suites.',
        imageUrl: 'assets/images/sofa_chairs.jpeg',
        material: 'Structured Foam & Matte Steel',
        dimensions: '70 cm x 70 cm x 85 cm',
        availableColors: ['#212121', '#757575'],
        isPopular: true,
      ),
    ];
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import '../models/advertisement_banner.dart';

class BannerProvider extends ChangeNotifier {
  int _currentIndex = 0;
  PageController? _pageController;
  Timer? _autoPlayTimer;
  List<AdvertisementBanner> _banners = [];

  BannerProvider() {
    _initBanners();
    _startAutoPlay();
  }

  int get currentIndex => _currentIndex;
  List<AdvertisementBanner> get banners => _banners;

  void setPageController(PageController controller) {
    _pageController = controller;
  }

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void _startAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_banners.isEmpty || _pageController == null) return;
      if (_pageController!.hasClients) {
        final nextIndex = (_currentIndex + 1) % _banners.length;
        _pageController!.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  void _initBanners() {
    _banners = [
      AdvertisementBanner(
        id: 'b1',
        title: 'Festive Home Refresh Sale',
        subtitle: 'Upgrade your living space with luxury curve sofas.',
        discountTag: 'UP TO 50% OFF',
        imageUrl: 'assets/images/curve_sofa.jpeg',
        gradientColors: [const Color(0xFF2C3E50), const Color(0xFF4CA1AF)],
        categoryAction: 'Sofa',
      ),
      AdvertisementBanner(
        id: 'b2',
        title: 'Grand 5-Seater Living Sets',
        subtitle: 'Plush seating crafted for family moments.',
        discountTag: 'FLAT 30% OFF',
        imageUrl: 'assets/images/five_seater_sofa.jpeg',
        gradientColors: [const Color(0xFFD4145A), const Color(0xFFFBB03B)],
        categoryAction: 'Sofa',
      ),
      AdvertisementBanner(
        id: 'b3',
        title: 'Cozy Accent Sofa Chairs',
        subtitle: 'Ergonomic curves for supreme relaxation.',
        discountTag: 'NEW ARRIVALS',
        imageUrl: 'assets/images/sofa_chairs.jpeg',
        gradientColors: [const Color(0xFF009245), const Color(0xFFFCEE21)],
        categoryAction: 'Chair',
      ),
    ];
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    super.dispose();
  }
}

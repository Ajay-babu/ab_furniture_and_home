import 'package:flutter/material.dart';

class AdvertisementBanner {
  final String id;
  final String title;
  final String subtitle;
  final String discountTag;
  final String imageUrl;
  final List<Color> gradientColors;
  final String categoryAction;

  AdvertisementBanner({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.discountTag,
    required this.imageUrl,
    required this.gradientColors,
    required this.categoryAction,
  });
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/banner_provider.dart';
import '../../../providers/furniture_provider.dart';

class AnimatedBannerSlideshow extends StatefulWidget {
  const AnimatedBannerSlideshow({super.key});

  @override
  State<AnimatedBannerSlideshow> createState() => _AnimatedBannerSlideshowState();
}

class _AnimatedBannerSlideshowState extends State<AnimatedBannerSlideshow> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.92);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BannerProvider>().setPageController(_pageController);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bannerProv = context.watch<BannerProvider>();
    final banners = bannerProv.banners;

    if (banners.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _pageController,
            itemCount: banners.length,
            onPageChanged: (index) {
              bannerProv.updateIndex(index);
            },
            itemBuilder: (context, index) {
              final banner = banners[index];
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: banner.gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: banner.gradientColors.first.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      // Background Image supporting both local asset JPEG & network URLs
                      Positioned(
                        right: -20,
                        top: -10,
                        bottom: -10,
                        width: 180,
                        child: Opacity(
                          opacity: 0.45,
                          child: banner.imageUrl.startsWith('assets/')
                              ? Image.asset(
                                  banner.imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.chair, size: 80, color: Colors.white24),
                                )
                              : Image.network(
                                  banner.imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.chair, size: 80, color: Colors.white24),
                                ),
                        ),
                      ),

                      // Text Content
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.amber[700],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                banner.discountTag,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              banner.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              banner.subtitle,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 12),
                            InkWell(
                              onTap: () {
                                context.read<FurnitureProvider>().selectCategory(banner.categoryAction);
                              },
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Explore Now',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 16),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // Indicator Dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(banners.length, (i) {
            final isActive = i == bannerProv.currentIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: isActive ? 24 : 8,
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF2C3E50) : Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}

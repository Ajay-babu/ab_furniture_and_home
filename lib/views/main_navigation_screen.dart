import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/profile_provider.dart';
import 'home/home_screen.dart';
import 'payment/checkout_screen.dart';
import 'profile/profile_screen.dart';
import 'widgets/side_drawer.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    CheckoutScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final cartProv = context.watch<CartProvider>();
    final profileProv = context.watch<ProfileProvider>();
    final user = profileProv.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AB Furniture & Home',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: const Color(0xFF2C3E50),
        foregroundColor: Colors.white,
        actions: [
          // Cart Icon with Badge
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined),
                onPressed: () {
                  setState(() => _currentIndex = 1);
                },
              ),
              if (cartProv.totalItemCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${cartProv.totalItemCount}',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          // User Avatar
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                setState(() => _currentIndex = 2);
              },
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white24,
                child: Text(
                  user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      // Side Drawer
      drawer: CustomSideDrawer(
        onSelectTab: (index) {
          setState(() => _currentIndex = index);
        },
      ),

      // Screen Body
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: Color(0xFF2C3E50)),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('${cartProv.totalItemCount}'),
              isLabelVisible: cartProv.totalItemCount > 0,
              child: const Icon(Icons.shopping_bag_outlined),
            ),
            selectedIcon: Badge(
              label: Text('${cartProv.totalItemCount}'),
              isLabelVisible: cartProv.totalItemCount > 0,
              child: const Icon(Icons.shopping_bag, color: Color(0xFF2C3E50)),
            ),
            label: 'Cart',
          ),
          const NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: Color(0xFF2C3E50)),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

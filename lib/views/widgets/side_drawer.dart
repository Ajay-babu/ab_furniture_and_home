import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/profile_provider.dart';
import '../../providers/cart_provider.dart';
import '../profile/profile_screen.dart';
import '../payment/upi_payment_screen.dart';
import '../support/customer_support_screen.dart';

class CustomSideDrawer extends StatelessWidget {
  final Function(int) onSelectTab;
  const CustomSideDrawer({super.key, required this.onSelectTab});

  @override
  Widget build(BuildContext context) {
    final profileProv = context.watch<ProfileProvider>();
    final cartProv = context.watch<CartProvider>();
    final user = profileProv.user;

    return Drawer(
      child: Column(
        children: [
          // Header
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2C3E50), Color(0xFF4CA1AF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
            ),
            accountName: Text(
              user.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(user.email),
          ),

          // Drawer Navigation Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(Icons.home_outlined, color: Color(0xFF2C3E50)),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                    onSelectTab(0);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.shopping_bag_outlined, color: Color(0xFF2C3E50)),
                  title: const Text('My Cart'),
                  trailing: cartProv.totalItemCount > 0
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.amber[800],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${cartProv.totalItemCount}',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        )
                      : null,
                  onTap: () {
                    Navigator.pop(context);
                    onSelectTab(1);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person_outline, color: Color(0xFF2C3E50)),
                  title: const Text('My Profile'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfileScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.account_balance_wallet_outlined, color: Color(0xFF2C3E50)),
                  title: const Text('UPI Payment Methods'),
                  subtitle: const Text('Fast & Secure UPI'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const UpiPaymentScreen(totalAmount: 0.0),
                      ),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.favorite_outline, color: Color(0xFF2C3E50)),
                  title: const Text('Favorites'),
                  onTap: () {
                    Navigator.pop(context);
                    onSelectTab(0);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.help_outline, color: Color(0xFF2C3E50)),
                  title: const Text('Customer Support'),
                  subtitle: const Text('24/7 Helpline & Care'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CustomerSupportScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Footer
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text('Logout', style: TextStyle(color: Colors.redAccent)),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out successfully')),
              );
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

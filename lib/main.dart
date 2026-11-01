import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/banner_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/furniture_provider.dart';
import 'providers/payment_provider.dart';
import 'providers/profile_provider.dart';
import 'views/main_navigation_screen.dart';

void main() {
  runApp(const ABFurnitureApp());
}

class ABFurnitureApp extends StatelessWidget {
  const ABFurnitureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FurnitureProvider()),
        ChangeNotifierProvider(create: (_) => BannerProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
      ],
      child: MaterialApp(
        title: 'AB Furniture & Home',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF2C3E50),
            primary: const Color(0xFF2C3E50),
            secondary: const Color(0xFF4CA1AF),
          ),
          scaffoldBackgroundColor: Colors.grey[50],
          appBarTheme: const AppBarTheme(
            elevation: 0,
            centerTitle: false,
          ),
        ),
        home: const MainNavigationScreen(),
      ),
    );
  }
}

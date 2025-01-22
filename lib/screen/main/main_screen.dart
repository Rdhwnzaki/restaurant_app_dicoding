import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/main/index_nav_provider.dart';
import 'package:restaurant_app/screen/home/home_screen.dart';
import 'package:restaurant_app/screen/favorite/favorite_screen.dart';
import 'package:restaurant_app/screen/setting/setting_screen.dart';
import 'package:restaurant_app/style/colors/restaurant_colors.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<IndexNavProvider>(builder: (context, value, child) {
        return switch (value.indexBottomNavBar) {
          0 => const FavoriteScreen(),
          1 => const HomeScreen(),
          _ => const SettingScreen()
        };
      }),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: RestaurantColors.primary.color,
          unselectedItemColor: RestaurantColors.surface.color,
          selectedItemColor: RestaurantColors.secondary.color,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 14,
          unselectedFontSize: 12,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          currentIndex: context.watch<IndexNavProvider>().indexBottomNavBar,
          onTap: (index) {
            context.read<IndexNavProvider>().setIndextBottomNavBar = index;
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favorite",
              tooltip: "Favorite",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              tooltip: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Setting",
              tooltip: "Setting",
            ),
          ]),
    );
  }
}

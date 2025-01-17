import 'package:flutter/material.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/style/colors/restaurant_colors.dart';
import 'package:restaurant_app/style/typography/restaurant_text_styles.dart';

class HomeAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Icon(
            Icons.restaurant_menu,
            color: RestaurantColors.onPrimary.color,
          ),
          const SizedBox(width: 8),
          Text(
            "Restaurant",
            style: RestaurantTextStyles.headlineSmall.copyWith(
              color: RestaurantColors.onPrimary.color,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          color: RestaurantColors.onPrimary.color,
          onPressed: () {
            Navigator.pushNamed(context, NavigationRoute.searchRoute.name);
          },
        ),
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      backgroundColor: RestaurantColors.primary.color,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(30.0),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            "Recommended restaurant for you!",
            style: RestaurantTextStyles.titleMedium.copyWith(
              color: RestaurantColors.onPrimary.color,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90.0);
}

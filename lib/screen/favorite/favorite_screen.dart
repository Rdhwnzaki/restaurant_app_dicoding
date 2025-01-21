import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail/favorite_list_provider.dart';
import 'package:restaurant_app/screen/favorite/favorite_card_widget.dart';
import 'package:restaurant_app/style/colors/restaurant_colors.dart';
import 'package:restaurant_app/style/typography/restaurant_text_styles.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.favorite,
              color: RestaurantColors.onPrimary.color,
            ),
            const SizedBox(width: 8),
            Text(
              "Favorite",
              style: RestaurantTextStyles.headlineSmall.copyWith(
                color: RestaurantColors.onPrimary.color,
              ),
            ),
          ],
        ),
        backgroundColor: RestaurantColors.primary.color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
      ),
      body: Consumer<FavoriteListProvider>(builder: (context, value, child) {
        final favoriteList = value.favoriteList;
        return switch (favoriteList.isNotEmpty) {
          true => ListView.builder(
              itemCount: favoriteList.length,
              itemBuilder: (context, index) {
                final restaurant = favoriteList[index];
                return FavoriteCardWidget(
                  restaurant: restaurant,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/detail',
                      arguments: restaurant.id,
                    );
                  },
                );
              }),
          _ => const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("No Favorited")],
              ),
            )
        };
      }),
    );
  }
}

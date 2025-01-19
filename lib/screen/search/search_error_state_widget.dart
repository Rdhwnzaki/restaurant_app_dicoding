import 'package:flutter/material.dart';
import 'package:restaurant_app/style/colors/restaurant_colors.dart';
import 'package:restaurant_app/style/typography/restaurant_text_styles.dart';

class SearchErrorStateWidget extends StatelessWidget {
  final String errorMessage;

  const SearchErrorStateWidget({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_outlined,
            size: 80,
            color: RestaurantColors.error.color,
          ),
          const SizedBox(height: 16),
          Text(
            "Failed to load data",
            style: RestaurantTextStyles.titleLarge.copyWith(
              color: RestaurantColors.error.color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: RestaurantTextStyles.bodyMedium.copyWith(
              color: RestaurantColors.onAlert.color,
            ),
          ),
        ],
      ),
    );
  }
}

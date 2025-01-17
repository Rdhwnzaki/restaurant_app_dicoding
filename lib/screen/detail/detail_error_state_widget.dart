import 'package:flutter/material.dart';
import 'package:restaurant_app/style/colors/restaurant_colors.dart';
import 'package:restaurant_app/style/typography/restaurant_text_styles.dart';

class DetailErrorStateWidget extends StatelessWidget {
  final String errorMessage;

  const DetailErrorStateWidget({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            size: 80,
            color: RestaurantColors.error.color,
          ),
          const SizedBox(height: 16),
          Text(
            "Error",
            style: RestaurantTextStyles.titleLarge.copyWith(
              color: RestaurantColors.error.color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: RestaurantTextStyles.bodyMedium.copyWith(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Go Back"),
          ),
        ],
      ),
    );
  }
}

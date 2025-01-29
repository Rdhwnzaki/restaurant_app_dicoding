import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail/restaurant_description_provider.dart';
import 'package:restaurant_app/style/typography/restaurant_text_styles.dart';

class RestaurantDescriptionWidget extends StatelessWidget {
  final String description;

  const RestaurantDescriptionWidget({required this.description, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantDescriptionProvider(),
      child: Consumer<RestaurantDescriptionProvider>(
        builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: RestaurantTextStyles.bodyMedium,
                maxLines: provider.isExpanded ? 2 : 1000,
                overflow: TextOverflow.ellipsis,
              ),
              if (description.length > 100)
                GestureDetector(
                  onTap: provider.toggleExpanded,
                  child: Text(
                    provider.isExpanded ? 'Read more' : 'Read less',
                    style: const TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

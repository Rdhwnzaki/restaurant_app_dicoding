import 'package:flutter/material.dart';
import 'package:restaurant_app/style/colors/restaurant_colors.dart';
import 'package:restaurant_app/style/typography/restaurant_text_styles.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearch;

  const SearchBarWidget({
    super.key,
    required this.searchController,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(12.0),
        child: TextField(
          controller: searchController,
          style: RestaurantTextStyles.titleSmall,
          decoration: InputDecoration(
            hintText: 'Search restaurants...',
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 14.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: RestaurantColors.primary.color,
                width: 2.0,
              ),
            ),
            suffixIcon: InkWell(
              borderRadius: BorderRadius.circular(12.0),
              onTap: () => onSearch(searchController.text),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  Icons.search_rounded,
                  color: RestaurantColors.primary.color,
                  size: 28.0,
                ),
              ),
            ),
          ),
          onSubmitted: onSearch,
        ),
      ),
    );
  }
}

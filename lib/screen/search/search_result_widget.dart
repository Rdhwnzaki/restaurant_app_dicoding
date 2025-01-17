import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/search/restaurant_search_provider.dart';
import 'package:restaurant_app/screen/loading_state_widget.dart';
import 'package:restaurant_app/static/restaurant_search_result_state.dart';
import 'package:restaurant_app/screen/home/restaurant_card_widget.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantSearchProvider>(
      builder: (context, provider, child) {
        final state = provider.resultState;

        if (state is RestaurantSearchNoneState) {
          return const Center(
            child: Text('Enter keywords to search for restaurants.'),
          );
        } else if (state is RestaurantSearchLoadingState) {
          return const Center(child: LoadingStateWidget());
        } else if (state is RestaurantSearchErrorState) {
          return Center(
            child: Text(
              state.error,
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (state is RestaurantSearchLoadedState) {
          final restaurants = state.data;

          if (restaurants.isEmpty) {
            return const Center(child: Text('No restaurants found.'));
          }

          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = restaurants[index];
              return RestaurantCardWidget(
                restaurant: restaurant,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/detail',
                    arguments: restaurant.id,
                  );
                },
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

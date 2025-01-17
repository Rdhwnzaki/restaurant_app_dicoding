import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/screen/detail/detail_appbar_widget.dart';
import 'package:restaurant_app/screen/loading_state_widget.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';
import 'package:restaurant_app/screen/detail/body_of_detail_screen_widget.dart';
import 'package:restaurant_app/screen/detail/detail_error_state_widget.dart';

class DetailScreen extends StatefulWidget {
  final String restaurantId;

  const DetailScreen({super.key, required this.restaurantId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    _fetchRestaurantDetail();
  }

  void _fetchRestaurantDetail() {
    Future.microtask(() {
      context
          .read<RestaurantDetailProvider>()
          .fetchRestaurantDetail(widget.restaurantId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DetailAppbarWidget(),
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, provider, child) {
          return switch (provider.resultState) {
            RestaurantDetailLoadingState() => const LoadingStateWidget(),
            RestaurantDetailLoadedState(data: var restaurant) =>
              BodyOfDetailScreenWidget(restaurant: restaurant),
            RestaurantDetailErrorState(error: var message) =>
              DetailErrorStateWidget(errorMessage: message),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}

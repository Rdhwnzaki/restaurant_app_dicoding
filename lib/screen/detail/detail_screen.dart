import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/screen/detail/add_review_section_widget.dart';
import 'package:restaurant_app/screen/detail/detail_appbar_widget.dart';
import 'package:restaurant_app/screen/loading_state_widget.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';
import 'package:restaurant_app/screen/detail/body_of_detail_screen_widget.dart';
import 'package:restaurant_app/screen/detail/detail_error_state_widget.dart';
import 'package:restaurant_app/style/colors/restaurant_colors.dart';
import 'package:restaurant_app/style/typography/restaurant_text_styles.dart';

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

  void _showAddReviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: AddReviewSectionWidget(restaurantId: widget.restaurantId),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DetailAppbarWidget(),
      body: Column(
        children: [
          Expanded(
            child: Consumer<RestaurantDetailProvider>(
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
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: ElevatedButton.icon(
              onPressed: () => _showAddReviewDialog(context),
              icon: Icon(
                Icons.add,
                size: 18,
                color: RestaurantColors.surface.color,
              ),
              label: Text(
                "Add Review",
                style: RestaurantTextStyles.titleSmall,
              ),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                backgroundColor: RestaurantColors.primary.color,
                foregroundColor: RestaurantColors.surface.color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 4,
              ),
            ),
          )
        ],
      ),
    );
  }
}

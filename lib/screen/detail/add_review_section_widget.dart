import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/review/restaurant_add_review_provider.dart';
import 'package:restaurant_app/screen/loading_state_widget.dart';
import 'package:restaurant_app/static/restaurant_review_result_state.dart';
import 'package:restaurant_app/screen/detail/custom_text_field.dart';
import 'package:restaurant_app/style/colors/restaurant_colors.dart';
import 'package:restaurant_app/style/typography/restaurant_text_styles.dart';
import 'package:restaurant_app/provider/detail/add_section_provider.dart';

class AddReviewSectionWidget extends StatefulWidget {
  final String restaurantId;

  const AddReviewSectionWidget({super.key, required this.restaurantId});

  @override
  State<AddReviewSectionWidget> createState() => _AddReviewSectionWidgetState();
}

class _AddReviewSectionWidgetState extends State<AddReviewSectionWidget> {
  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  void _submitReview(BuildContext context) {
    final name = _nameController.text.trim();
    final review = _reviewController.text.trim();

    if (name.isEmpty || review.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Name and review cannot be empty")),
      );
      return;
    }

    final reviewProvider = context.read<RestaurantAddReviewProvider>();
    final sectionProvider = context.read<AddReviewSectionProvider>();

    sectionProvider.resetState();
    reviewProvider.createRestaurantReview(widget.restaurantId, name, review);
  }

  void _onSuccess(BuildContext context) {
    final sectionProvider = context.read<AddReviewSectionProvider>();
    if (!sectionProvider.hasUpdatedDetail) {
      sectionProvider.setSuccessMessage("Review successfully added!");
      _nameController.clear();
      _reviewController.clear();

      context
          .read<RestaurantDetailProvider>()
          .fetchRestaurantDetail(widget.restaurantId);
      sectionProvider.markDetailUpdated();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddReviewSectionProvider(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<AddReviewSectionProvider>(
          builder: (context, sectionProvider, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Add Review",
                      style: RestaurantTextStyles.titleMedium,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (sectionProvider.successMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      sectionProvider.successMessage!,
                      style: RestaurantTextStyles.titleSmall
                          .copyWith(color: RestaurantColors.primary.color),
                    ),
                  ),
                CustomTextField(
                  controller: _nameController,
                  labelText: "Your Name",
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: _reviewController,
                  labelText: "Your Review",
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                Consumer<RestaurantAddReviewProvider>(
                  builder: (context, provider, child) {
                    if (provider.resultState is RestaurantReviewLoadingState) {
                      return const Center(
                        child: LoadingStateWidget(),
                      );
                    }

                    if (provider.resultState is RestaurantReviewErrorState) {
                      final error =
                          (provider.resultState as RestaurantReviewErrorState)
                              .error;
                      return Text(
                        error,
                        style: RestaurantTextStyles.titleSmall
                            .copyWith(color: RestaurantColors.error.color),
                      );
                    }

                    if (provider.resultState is RestaurantReviewLoadedState &&
                        !sectionProvider.hasUpdatedDetail) {
                      Future.microtask(() => _onSuccess(context));
                    }

                    return ElevatedButton(
                      onPressed: () => _submitReview(context),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text("Submit Review"),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

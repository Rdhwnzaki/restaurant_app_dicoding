import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/static/restaurant_review_result_state.dart';

class RestaurantAddReviewProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantAddReviewProvider(
    this._apiServices,
  );

  RestaurantReviewResultState _resultState = RestaurantReviewNoneState();

  RestaurantReviewResultState get resultState => _resultState;

  Future<void> createRestaurantReview(
    String id,
    String name,
    String review,
  ) async {
    try {
      _resultState = RestaurantReviewLoadingState();
      notifyListeners();

      await Future.delayed(const Duration(seconds: 2));

      final result = await _apiServices.postRestaurantReview(
        id,
        name,
        review,
      );

      if (result.error) {
        _resultState = RestaurantReviewErrorState(
          "Failed to add review. Please try again.",
        );
      } else {
        _resultState = RestaurantReviewLoadedState(result.customerReviews);
      }
    } on SocketException {
      _resultState = RestaurantReviewErrorState(
        "Your internet connection is problematic. Make sure you are connected to the network.",
      );
    } on HttpException {
      _resultState = RestaurantReviewErrorState(
        "Unable to connect to server. Please try again later.",
      );
    } on FormatException {
      _resultState = RestaurantReviewErrorState(
        "The data received from the server is invalid.",
      );
    } catch (e) {
      _resultState = RestaurantReviewErrorState(
        "An unknown error has occurred. Please try again.",
      );
    } finally {
      notifyListeners();
    }
  }
}

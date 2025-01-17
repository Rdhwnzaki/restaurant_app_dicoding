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
        _resultState = RestaurantReviewErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantReviewLoadedState(result.customerReviews);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = RestaurantReviewErrorState(e.toString());
      notifyListeners();
    }
  }
}

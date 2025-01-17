import "package:restaurant_app/data/model/restaurant_review.dart";

class RestaurantReviewResponse {
  bool error;
  String message;
  List<RestaurantReview> customerReviews;

  RestaurantReviewResponse({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory RestaurantReviewResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantReviewResponse(
        error: json["error"],
        message: json["message"],
        customerReviews: json["customerReviews"] != null
            ? List<RestaurantReview>.from(json["customerReviews"]!
                .map((x) => RestaurantReview.fromJson(x)))
            : <RestaurantReview>[]);
  }
}

import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/static/restaurant_detail_result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantDetailProvider(
    this._apiServices,
  );

  RestaurantDetailResultState _resultState = RestaurantDetailNoneState();

  RestaurantDetailResultState get resultState => _resultState;

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      _resultState = RestaurantDetailLoadingState();
      notifyListeners();

      await Future.delayed(const Duration(seconds: 2));

      final result = await _apiServices.getRestaurantDetail(id);

      if (result.error) {
        _resultState = RestaurantDetailErrorState(
          "Failed to load restaurant detail. Please try again.",
        );
        notifyListeners();
      } else {
        _resultState = RestaurantDetailLoadedState(result.restaurant);
        notifyListeners();
      }
    } on SocketException {
      _resultState = RestaurantDetailErrorState(
        "Your internet connection is problematic. Make sure you are connected to the network.",
      );
    } on HttpException {
      _resultState = RestaurantDetailErrorState(
        "Unable to connect to server. Please try again later.",
      );
    } on FormatException {
      _resultState = RestaurantDetailErrorState(
        "The data received from the server is invalid.",
      );
    } catch (e) {
      _resultState = RestaurantDetailErrorState(
        "An unknown error has occurred. Please try again.",
      );
    } finally {
      notifyListeners();
    }
  }
}

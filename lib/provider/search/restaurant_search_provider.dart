import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/static/restaurant_search_result_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantSearchProvider(
    this._apiServices,
  );

  RestaurantSearchResultState _resultState = RestaurantSearchNoneState();

  RestaurantSearchResultState get resultState => _resultState;

  Future<void> fetchRestaurantQuery(String query) async {
    try {
      _resultState = RestaurantSearchLoadingState();
      notifyListeners();

      await Future.delayed(const Duration(seconds: 2));

      final result = await _apiServices.getRestaurantByQuery(query);

      if (result.error) {
        _resultState = RestaurantSearchErrorState(
          "Failed to load restaurant data. Please try again..",
        );
        notifyListeners();
      } else {
        _resultState = RestaurantSearchLoadedState(result.restaurants);
        notifyListeners();
      }
    } on SocketException {
      _resultState = RestaurantSearchErrorState(
        "Your internet connection is problematic. Make sure you are connected to the network.",
      );
    } on HttpException {
      _resultState = RestaurantSearchErrorState(
        "Unable to connect to server. Please try again later.",
      );
    } on FormatException {
      _resultState = RestaurantSearchErrorState(
        "The data received from the server is invalid.",
      );
    } catch (e) {
      _resultState = RestaurantSearchErrorState(
        "An unknown error has occurred. Please try again.",
      );
    } finally {
      notifyListeners();
    }
  }
}

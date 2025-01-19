import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantListProvider(
    this._apiServices,
  );

  RestaurantListResultState _resultState = RestaurantListNoneState();

  RestaurantListResultState get resultState => _resultState;

  Future<void> fetchRestaurantList() async {
    try {
      _resultState = RestaurantListLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestaurantList();

      if (result.error) {
        _resultState = RestaurantListErrorState(
          "Failed to load restaurant data. Please try again.",
        );
      } else {
        _resultState = RestaurantListLoadedState(result.restaurants);
      }
    } on SocketException {
      _resultState = RestaurantListErrorState(
        "Your internet connection is problematic. Make sure you are connected to the network.",
      );
    } on HttpException {
      _resultState = RestaurantListErrorState(
        "Unable to connect to server. Please try again later.",
      );
    } on FormatException {
      _resultState = RestaurantListErrorState(
        "The data received from the server is invalid.",
      );
    } catch (e) {
      _resultState = RestaurantListErrorState(
        "An unknown error has occurred. Please try again.",
      );
    } finally {
      notifyListeners();
    }
  }
}

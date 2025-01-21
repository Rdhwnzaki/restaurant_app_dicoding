import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

class FavoriteListProvider extends ChangeNotifier {
  final List<RestaurantDetail> _favoriteList = [];

  List<RestaurantDetail> get favoriteList => _favoriteList;

  void addFavorite(RestaurantDetail value) {
    _favoriteList.add(value);
    notifyListeners();
  }

  void removeFavorite(RestaurantDetail value) {
    _favoriteList.removeWhere((element) => element.id == value.id);
    notifyListeners();
  }

  bool checkItemFavorite(RestaurantDetail value) {
    final tourismInList =
        _favoriteList.where((element) => element.id == value.id);
    return tourismInList.isNotEmpty;
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/static/restaurant_list_result_state.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class MockApiServices extends Mock implements ApiServices {}

void main() {
  late MockApiServices mockApiServices;
  late RestaurantListProvider provider;

  setUp(() {
    mockApiServices = MockApiServices();
    provider = RestaurantListProvider(mockApiServices);
  });

  group('RestaurantListProvider Tests', () {
    test('Initial state should be RestaurantListNoneState', () {
      expect(provider.resultState, isA<RestaurantListNoneState>());
    });

    test('Should return list of restaurants when API call is successful',
        () async {
      final mockResponse = RestaurantListResponse(
        error: false,
        message: "success",
        count: 20,
        restaurants: [
          Restaurant(
            id: "rqdv5juczeskfw1e867",
            name: "Melting Pot",
            description: "Lorem ipsum dolor sit amet...",
            pictureId: "14",
            city: "Medan",
            rating: 4.2,
          ),
          Restaurant(
            id: "s1knt6za9kkfw1e867",
            name: "Kafe Kita",
            description: "Quisque rutrum. Aenean imperdiet...",
            pictureId: "25",
            city: "Gorontalo",
            rating: 4.0,
          ),
        ],
      );

      when(() => mockApiServices.getRestaurantList()).thenAnswer(
        (_) async => mockResponse,
      );

      await provider.fetchRestaurantList();

      expect(provider.resultState, isA<RestaurantListLoadedState>());
      final loadedState = provider.resultState as RestaurantListLoadedState;

      expect(loadedState.data.length, 2);
      expect(loadedState.data.first.name, "Melting Pot");
    });

    test('Should return error state when API call fails', () async {
      when(() => mockApiServices.getRestaurantList())
          .thenThrow(Exception("API error"));

      await provider.fetchRestaurantList();

      expect(provider.resultState, isA<RestaurantListErrorState>());
      final errorState = provider.resultState as RestaurantListErrorState;

      expect(errorState.error, contains("An unknown error has occurred"));
    });
  });
}

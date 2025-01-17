import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/search/restaurant_search_provider.dart';
import 'package:restaurant_app/screen/search/search_appbar_widget.dart';
import 'package:restaurant_app/screen/search/search_bar_widget.dart';
import 'package:restaurant_app/screen/search/search_result_widget.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SearchAppbarWidget(),
      body: Column(
        children: [
          SearchBarWidget(
            searchController: _searchController,
            onSearch: (query) {
              if (query.isNotEmpty) {
                context
                    .read<RestaurantSearchProvider>()
                    .fetchRestaurantQuery(query);
              }
            },
          ),
          const Expanded(child: SearchResultWidget()),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

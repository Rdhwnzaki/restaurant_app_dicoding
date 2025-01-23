import 'package:flutter/material.dart';
import 'package:restaurant_app/style/typography/restaurant_text_styles.dart';

class RestaurantDescriptionWidget extends StatefulWidget {
  final String description;

  const RestaurantDescriptionWidget({required this.description, Key? key})
      : super(key: key);

  @override
  _RestaurantDescriptionWidgetState createState() =>
      _RestaurantDescriptionWidgetState();
}

class _RestaurantDescriptionWidgetState
    extends State<RestaurantDescriptionWidget> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.description,
          style: RestaurantTextStyles.bodyMedium,
          maxLines: _isExpanded ? 2 : 1000,
          overflow: TextOverflow.ellipsis,
        ),
        if (widget.description.length > 100)
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Text(
              _isExpanded ? 'Read more' : 'Read less',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String restaurantId;

  const DetailScreen({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant Detail"),
      ),
      body: Text("Detail Screen"),
    );
  }
}

import 'package:flutter/material.dart';

enum RestaurantColors {
  primary("Primary", Color(0xFF008000)),
  secondary("Secondary", Color.fromARGB(255, 197, 218, 3)),
  background("Background", Color(0xFFF6F6F6)),
  surface("Surface", Colors.white),
  error("Error", Color(0xFFB00020)),
  onPrimary("OnPrimary", Colors.white),
  onSecondary("OnSecondary", Colors.black),
  onError("OnError", Colors.white),
  locationIcon("LocationIcon", Colors.red),
  ratingIcon("RatingIcon", Colors.yellow),
  onAlert("OnAlert", Colors.grey);

  const RestaurantColors(this.name, this.color);

  final String name;
  final Color color;
}

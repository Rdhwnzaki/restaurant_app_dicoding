import 'package:flutter/material.dart';

class AddReviewSectionProvider extends ChangeNotifier {
  String? successMessage;
  bool hasUpdatedDetail = false;

  void resetState() {
    successMessage = null;
    hasUpdatedDetail = false;
    notifyListeners();
  }

  void setSuccessMessage(String message) {
    successMessage = message;
    notifyListeners();
  }

  void markDetailUpdated() {
    hasUpdatedDetail = true;
    notifyListeners();
  }
}

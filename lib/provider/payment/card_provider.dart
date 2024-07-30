// card_provider.dart
import 'package:flutter/material.dart';

class CardProvider with ChangeNotifier {
  String _cardHolderName = '';
  String _cardNumber = '';
  String _cvv = '';
  String _expiryMonth = '';
  String _expiryYear = '';

  String get cardHolderName => _cardHolderName;
  String get cardNumber => _cardNumber;
  String get cvv => _cvv;
  String get expiryMonth => _expiryMonth;
  String get expiryYear => _expiryYear;

  void updateCardHolderName(String name) {
    _cardHolderName = name;
    notifyListeners();
  }

  void updateCardNumber(String number) {
    _cardNumber = number;
    notifyListeners();
  }

  void updateCVV(String cvv) {
    _cvv = cvv;
    notifyListeners();
  }

  void updateExpiryMonth(String month) {
    _expiryMonth = month;
    notifyListeners();
  }

  void updateExpiryYear(String year) {
    _expiryYear = year;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

import '../../model/paymentpayment/payment_model.dart';
import '../../model/paymentpayment/payment_response.dart';
import '../../services/payment/payment_services.dart';



class PaymentProvider with ChangeNotifier {
  final PaymentService _paymentService = PaymentService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  PaymentResponse? _paymentResponse;
  PaymentResponse? get paymentResponse => _paymentResponse;

  Future<void> makePayment(PaymentModel paymentModel) async {
    _isLoading = true;
    notifyListeners();

    try {
      _paymentResponse = await _paymentService.createPayment(paymentModel);
    } catch (e) {
      _paymentResponse = null;
      print(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

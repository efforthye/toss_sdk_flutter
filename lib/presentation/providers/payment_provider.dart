import 'package:flutter/foundation.dart';
import '../../data/models/payment_request.dart';
import '../../data/models/payment_response.dart';
import '../../data/services/payment_service.dart';

class PaymentProvider extends ChangeNotifier {
  final PaymentService _paymentService = PaymentService();
  
  bool _isLoading = false;
  PaymentResponse? _paymentResult;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  PaymentResponse? get paymentResult => _paymentResult;
  String? get errorMessage => _errorMessage;

  Future<void> processPayment(PaymentRequest request) async {
    _isLoading = true;
    _errorMessage = null;
    _paymentResult = null;
    notifyListeners();

    try {
      final result = await _paymentService.processPayment(request);
      _paymentResult = result;
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('Payment error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearResult() {
    _paymentResult = null;
    _errorMessage = null;
    notifyListeners();
  }
}
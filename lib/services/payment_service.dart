import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';

class PaymentService {
  static const String _baseUrl = 'http://localhost:3001/api/payment';
  
  Future<String?> createPayment({
    required int amount,
    required String orderName,
    required String customerName,
    required String customerEmail,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/create'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'amount': amount,
          'orderName': orderName,
          'customerName': customerName,
          'customerEmail': customerEmail,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['checkoutUrl'] as String?;
      } else {
        debugPrint('Payment creation failed: ${response.statusCode}');
        debugPrint('Response body: ${response.body}');
        throw Exception('결제 생성에 실패했습니다.');
      }
    } catch (e) {
      debugPrint('Payment service error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> confirmPayment({
    required String paymentKey,
    required String orderId,
    required int amount,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/confirm'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'paymentKey': paymentKey,
          'orderId': orderId,
          'amount': amount,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        debugPrint('Payment confirmation failed: ${response.statusCode}');
        throw Exception('결제 승인에 실패했습니다.');
      }
    } catch (e) {
      debugPrint('Payment confirmation error: $e');
      rethrow;
    }
  }
}
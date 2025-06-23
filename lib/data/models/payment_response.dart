class PaymentResponse {
  final String status;
  final String? paymentKey;
  final String? orderId;
  final int? amount;
  final String? method;
  final String? approvedAt;
  final String? code;
  final String? message;
  final Map<String, dynamic>? rawData;

  PaymentResponse({
    required this.status,
    this.paymentKey,
    this.orderId,
    this.amount,
    this.method,
    this.approvedAt,
    this.code,
    this.message,
    this.rawData,
  });

  factory PaymentResponse.success({
    required String paymentKey,
    required String orderId,
    required int amount,
    required String method,
    required String approvedAt,
    Map<String, dynamic>? rawData,
  }) {
    return PaymentResponse(
      status: 'SUCCESS',
      paymentKey: paymentKey,
      orderId: orderId,
      amount: amount,
      method: method,
      approvedAt: approvedAt,
      rawData: rawData,
    );
  }

  factory PaymentResponse.failure({
    required String code,
    required String message,
    Map<String, dynamic>? rawData,
  }) {
    return PaymentResponse(
      status: 'FAILURE',
      code: code,
      message: message,
      rawData: rawData,
    );
  }

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    // 성공 케이스
    if (json.containsKey('paymentKey') && json.containsKey('orderId')) {
      return PaymentResponse.success(
        paymentKey: json['paymentKey'] ?? '',
        orderId: json['orderId'] ?? '',
        amount: json['totalAmount'] ?? json['amount'] ?? 0,
        method: json['method'] ?? '',
        approvedAt: json['approvedAt'] ?? '',
        rawData: json,
      );
    }
    
    // 실패 케이스
    return PaymentResponse.failure(
      code: json['code'] ?? 'UNKNOWN_ERROR',
      message: json['message'] ?? '알 수 없는 오류가 발생했습니다.',
      rawData: json,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'paymentKey': paymentKey,
      'orderId': orderId,
      'amount': amount,
      'method': method,
      'approvedAt': approvedAt,
      'code': code,
      'message': message,
      'rawData': rawData,
    };
  }

  bool get isSuccess => status == 'SUCCESS';
  bool get isFailure => status == 'FAILURE';

  @override
  String toString() {
    if (isSuccess) {
      return 'PaymentResponse.success(paymentKey: $paymentKey, orderId: $orderId, amount: $amount)';
    } else {
      return 'PaymentResponse.failure(code: $code, message: $message)';
    }
  }
}
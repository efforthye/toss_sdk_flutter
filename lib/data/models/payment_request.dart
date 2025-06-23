class PaymentRequest {
  final int amount;
  final String orderName;
  final String paymentMethod;
  final String customerName;
  final String customerEmail;
  final String? successUrl;
  final String? failUrl;

  PaymentRequest({
    required this.amount,
    required this.orderName,
    required this.paymentMethod,
    required this.customerName,
    required this.customerEmail,
    this.successUrl,
    this.failUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'orderName': orderName,
      'paymentMethod': paymentMethod,
      'customerName': customerName,
      'customerEmail': customerEmail,
      'successUrl': successUrl,
      'failUrl': failUrl,
    };
  }

  factory PaymentRequest.fromJson(Map<String, dynamic> json) {
    return PaymentRequest(
      amount: json['amount'] ?? 0,
      orderName: json['orderName'] ?? '',
      paymentMethod: json['paymentMethod'] ?? '',
      customerName: json['customerName'] ?? '',
      customerEmail: json['customerEmail'] ?? '',
      successUrl: json['successUrl'],
      failUrl: json['failUrl'],
    );
  }

  @override
  String toString() {
    return 'PaymentRequest(amount: $amount, orderName: $orderName, paymentMethod: $paymentMethod, customerName: $customerName, customerEmail: $customerEmail)';
  }
}
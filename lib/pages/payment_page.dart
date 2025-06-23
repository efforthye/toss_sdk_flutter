import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../services/payment_service.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final PaymentService _paymentService = PaymentService();
  bool _isLoading = false;
  String? _paymentUrl;
  WebViewController? _webViewController;

  // 결제 정보
  final int _amount = 15000;
  final String _orderName = "토스 티셔츠";
  final String _customerName = "김토스";
  final String _customerEmail = "customer123@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('결제하기'),
        backgroundColor: const Color(0xFF3182F6),
        foregroundColor: Colors.white,
      ),
      body: _paymentUrl == null
          ? _buildPaymentForm()
          : _buildWebView(),
    );
  }

  Widget _buildPaymentForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '주문 정보',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('상품명', _orderName),
                  _buildInfoRow('결제 금액', '${_amount.toString()}원'),
                  _buildInfoRow('주문자', _customerName),
                  _buildInfoRow('이메일', _customerEmail),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isLoading ? null : _initiatePayment,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3182F6),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(fontSize: 18),
            ),
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text('${_amount.toString()}원 결제하기'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildWebView() {
    return Column(
      children: [
        LinearProgressIndicator(
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF3182F6)),
        ),
        Expanded(
          child: WebViewWidget(
            controller: _webViewController!,
          ),
        ),
      ],
    );
  }

  Future<void> _initiatePayment() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final paymentUrl = await _paymentService.createPayment(
        amount: _amount,
        orderName: _orderName,
        customerName: _customerName,
        customerEmail: _customerEmail,
      );

      if (paymentUrl != null) {
        setState(() {
          _paymentUrl = paymentUrl;
          _webViewController = WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setNavigationDelegate(
              NavigationDelegate(
                onPageStarted: (String url) {
                  debugPrint('Page started loading: $url');
                },
                onPageFinished: (String url) {
                  debugPrint('Page finished loading: $url');
                },
                onNavigationRequest: (NavigationRequest request) {
                  debugPrint('Navigation request: ${request.url}');
                  
                  // 결제 완료/실패 URL 처리
                  if (request.url.contains('/payment/success') ||
                      request.url.contains('/payment/fail')) {
                    _handlePaymentResult(request.url);
                    return NavigationDecision.prevent;
                  }
                  
                  return NavigationDecision.navigate;
                },
              ),
            )
            ..loadRequest(Uri.parse(paymentUrl));
        });
      }
    } catch (e) {
      _showErrorDialog('결제 준비 중 오류가 발생했습니다: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handlePaymentResult(String url) {
    final uri = Uri.parse(url);
    final queryParams = uri.queryParameters;

    if (url.contains('/payment/success')) {
      _showSuccessDialog(queryParams);
    } else {
      _showFailureDialog(queryParams);
    }
  }

  void _showSuccessDialog(Map<String, String> params) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 48,
        ),
        title: const Text('결제 성공'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('주문번호: ${params['orderId'] ?? 'N/A'}'),
            Text('결제키: ${params['paymentKey'] ?? 'N/A'}'),
            Text('결제금액: ${params['amount'] ?? 'N/A'}원'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  void _showFailureDialog(Map<String, String> params) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.error,
          color: Colors.red,
          size: 48,
        ),
        title: const Text('결제 실패'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('오류 코드: ${params['code'] ?? 'N/A'}'),
            Text('오류 메시지: ${params['message'] ?? 'N/A'}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('오류'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}
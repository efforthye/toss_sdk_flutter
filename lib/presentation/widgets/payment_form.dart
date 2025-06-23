import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/payment_request.dart';
import '../providers/payment_provider.dart';

class PaymentForm extends StatefulWidget {
  const PaymentForm({super.key});

  @override
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController(text: '10000');
  final _orderNameController = TextEditingController(text: '테스트 상품');
  final _customerNameController = TextEditingController(text: '홍길동');
  final _customerEmailController = TextEditingController(text: 'test@example.com');

  String _paymentMethod = 'CARD';

  @override
  void dispose() {
    _amountController.dispose();
    _orderNameController.dispose();
    _customerNameController.dispose();
    _customerEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '결제 정보',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              // 결제 금액
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: '결제 금액',
                  hintText: '결제할 금액을 입력하세요',
                  suffixText: '원',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '결제 금액을 입력하세요';
                  }
                  final amount = int.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return '유효한 금액을 입력하세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // 상품명
              TextFormField(
                controller: _orderNameController,
                decoration: const InputDecoration(
                  labelText: '상품명',
                  hintText: '주문할 상품명을 입력하세요',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '상품명을 입력하세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // 결제 방법
              DropdownButtonFormField<String>(
                value: _paymentMethod,
                decoration: const InputDecoration(
                  labelText: '결제 방법',
                ),
                items: const [
                  DropdownMenuItem(value: 'CARD', child: Text('카드')),
                  DropdownMenuItem(value: 'TRANSFER', child: Text('계좌이체')),
                  DropdownMenuItem(value: 'VIRTUAL_ACCOUNT', child: Text('가상계좌')),
                  DropdownMenuItem(value: 'MOBILE_PHONE', child: Text('휴대폰')),
                ],
                onChanged: (value) {
                  setState(() {
                    _paymentMethod = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              
              // 고객 이름
              TextFormField(
                controller: _customerNameController,
                decoration: const InputDecoration(
                  labelText: '고객 이름',
                  hintText: '결제자 이름을 입력하세요',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '고객 이름을 입력하세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // 고객 이메일
              TextFormField(
                controller: _customerEmailController,
                decoration: const InputDecoration(
                  labelText: '고객 이메일',
                  hintText: '결제자 이메일을 입력하세요',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '고객 이메일을 입력하세요';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return '유효한 이메일을 입력하세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              
              // 결제하기 버튼
              Consumer<PaymentProvider>(
                builder: (context, paymentProvider, child) {
                  return ElevatedButton(
                    onPressed: paymentProvider.isLoading ? null : _handlePayment,
                    child: paymentProvider.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('결제하기'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handlePayment() {
    if (_formKey.currentState!.validate()) {
      final request = PaymentRequest(
        amount: int.parse(_amountController.text),
        orderName: _orderNameController.text,
        paymentMethod: _paymentMethod,
        customerName: _customerNameController.text,
        customerEmail: _customerEmailController.text,
      );

      context.read<PaymentProvider>().processPayment(request);
    }
  }
}
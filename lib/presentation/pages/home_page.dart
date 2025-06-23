import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/payment_provider.dart';
import '../widgets/payment_form.dart';
import '../widgets/payment_result.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toss SDK Flutter'),
      ),
      body: SingleChildScrollView(
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
                    Text(
                      '토스 결제 테스트',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '토스 SDK를 사용한 결제 기능을 테스트해보세요.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const PaymentForm(),
            const SizedBox(height: 24),
            Consumer<PaymentProvider>(
              builder: (context, paymentProvider, child) {
                if (paymentProvider.isLoading) {
                  return const Card(
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text('결제 처리 중...'),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                
                if (paymentProvider.paymentResult != null) {
                  return PaymentResult(result: paymentProvider.paymentResult!);
                }
                
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
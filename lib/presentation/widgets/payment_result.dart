import 'package:flutter/material.dart';
import '../../data/models/payment_response.dart';

class PaymentResult extends StatelessWidget {
  final PaymentResponse result;

  const PaymentResult({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final isSuccess = result.status == 'SUCCESS';
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isSuccess ? Icons.check_circle : Icons.error,
                  color: isSuccess 
                      ? Theme.of(context).colorScheme.primary 
                      : Theme.of(context).colorScheme.error,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  isSuccess ? '결제 성공' : '결제 실패',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isSuccess 
                        ? Theme.of(context).colorScheme.primary 
                        : Theme.of(context).colorScheme.error,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            if (isSuccess) ...[
              _buildResultRow('주문번호', result.orderId ?? ''),
              _buildResultRow('결제키', result.paymentKey ?? ''),
              _buildResultRow('결제 금액', '${result.amount?.toString() ?? '0'}원'),
              _buildResultRow('결제 방법', result.method ?? ''),
              _buildResultRow('결제 시간', result.approvedAt ?? ''),
            ] else ...[
              _buildResultRow('실패 코드', result.code ?? ''),
              _buildResultRow('실패 메시지', result.message ?? ''),
            ],
            
            const SizedBox(height: 16),
            
            // JSON 상세 정보 (개발용)
            ExpansionTile(
              title: const Text('상세 정보 (JSON)'),
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                    ),
                  ),
                  child: SelectableText(
                    result.toJson().toString(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SelectableText(
              value,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
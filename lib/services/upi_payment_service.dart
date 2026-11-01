import 'dart:math';

import '../models/payment_models.dart';

class UpiPaymentService {
  // Simulated UPI payment processing service
  Future<TransactionResult> processUpiPayment({
    required double amount,
    required String upiId,
    required String paymentAppName,
  }) async {
    // Simulate network delay for payment transaction
    await Future.delayed(const Duration(seconds: 3));

    // Simple UPI ID validation regex check
    final upiRegex = RegExp(r'^[\w\.\-]+@[\w\-]+$');
    if (!upiRegex.hasMatch(upiId.trim())) {
      throw Exception("Invalid UPI ID format. E.g. user@okaxis or name@upi");
    }

    final random = Random();
    final isSuccess = random.nextDouble() < 0.95; // 95% success rate for simulation

    if (isSuccess) {
      final txnId = "TXN${DateTime.now().millisecondsSinceEpoch}${random.nextInt(1000)}";
      return TransactionResult(
        transactionId: txnId,
        statusMessage: "Payment Successful",
        amount: amount,
        timestamp: DateTime.now(),
        paymentMethod: "$paymentAppName ($upiId)",
      );
    } else {
      throw Exception("Transaction declined by bank/UPI provider. Please try again.");
    }
  }
}

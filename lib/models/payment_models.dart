enum PaymentStatus { idle, processing, success, failed }

enum PaymentApp { gpay, phonepe, paytm, bhim, customUpi }

class UpiPaymentOption {
  final PaymentApp app;
  final String title;
  final String iconAsset;
  final String upiHandle;

  UpiPaymentOption({
    required this.app,
    required this.title,
    required this.iconAsset,
    required this.upiHandle,
  });
}

class TransactionResult {
  final String transactionId;
  final String statusMessage;
  final double amount;
  final DateTime timestamp;
  final String paymentMethod;

  TransactionResult({
    required this.transactionId,
    required this.statusMessage,
    required this.amount,
    required this.timestamp,
    required this.paymentMethod,
  });
}

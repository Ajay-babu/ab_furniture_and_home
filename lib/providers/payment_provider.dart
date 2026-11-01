import 'package:flutter/material.dart';
import '../models/payment_models.dart';
import '../services/upi_payment_service.dart';

class PaymentProvider extends ChangeNotifier {
  final UpiPaymentService _paymentService = UpiPaymentService();

  PaymentStatus _status = PaymentStatus.idle;
  PaymentApp _selectedApp = PaymentApp.gpay;
  String _customUpiId = '';
  String? _errorMessage;
  TransactionResult? _lastTransaction;

  PaymentStatus get status => _status;
  PaymentApp get selectedApp => _selectedApp;
  String get customUpiId => _customUpiId;
  String? get errorMessage => _errorMessage;
  TransactionResult? get lastTransaction => _lastTransaction;

  final List<UpiPaymentOption> availableUpiOptions = [
    UpiPaymentOption(
      app: PaymentApp.gpay,
      title: 'Google Pay (UPI)',
      iconAsset: 'assets/icons/gpay.png',
      upiHandle: 'user@okaxis',
    ),
    UpiPaymentOption(
      app: PaymentApp.phonepe,
      title: 'PhonePe',
      iconAsset: 'assets/icons/phonepe.png',
      upiHandle: 'user@ybl',
    ),
    UpiPaymentOption(
      app: PaymentApp.paytm,
      title: 'Paytm UPI',
      iconAsset: 'assets/icons/paytm.png',
      upiHandle: 'user@paytm',
    ),
    UpiPaymentOption(
      app: PaymentApp.bhim,
      title: 'BHIM UPI',
      iconAsset: 'assets/icons/bhim.png',
      upiHandle: 'user@upi',
    ),
    UpiPaymentOption(
      app: PaymentApp.customUpi,
      title: 'Enter Custom UPI ID',
      iconAsset: 'assets/icons/upi.png',
      upiHandle: '',
    ),
  ];

  void selectPaymentApp(PaymentApp app) {
    _selectedApp = app;
    _errorMessage = null;
    notifyListeners();
  }

  void setCustomUpiId(String id) {
    _customUpiId = id;
    notifyListeners();
  }

  void resetPaymentState() {
    _status = PaymentStatus.idle;
    _errorMessage = null;
    _lastTransaction = null;
    notifyListeners();
  }

  Future<bool> initiateUpiPayment({required double amount}) async {
    _status = PaymentStatus.processing;
    _errorMessage = null;
    notifyListeners();

    try {
      final option = availableUpiOptions.firstWhere((o) => o.app == _selectedApp);
      final activeUpiId = _selectedApp == PaymentApp.customUpi
          ? _customUpiId
          : option.upiHandle;

      if (activeUpiId.isEmpty) {
        throw Exception("Please enter a valid UPI ID (e.g. mobile@upi)");
      }

      final result = await _paymentService.processUpiPayment(
        amount: amount,
        upiId: activeUpiId,
        paymentAppName: option.title,
      );

      _lastTransaction = result;
      _status = PaymentStatus.success;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll("Exception: ", "");
      _status = PaymentStatus.failed;
      notifyListeners();
      return false;
    }
  }
}

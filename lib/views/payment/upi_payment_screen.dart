import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/payment_models.dart';
import '../../providers/cart_provider.dart';
import '../../providers/payment_provider.dart';
import '../main_navigation_screen.dart';

class UpiPaymentScreen extends StatefulWidget {
  final double totalAmount;
  const UpiPaymentScreen({super.key, required this.totalAmount});

  @override
  State<UpiPaymentScreen> createState() => _UpiPaymentScreenState();
}

class _UpiPaymentScreenState extends State<UpiPaymentScreen> {
  final TextEditingController _upiIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PaymentProvider>().resetPaymentState();
    });
  }

  @override
  void dispose() {
    _upiIdController.dispose();
    super.dispose();
  }

  void _processPayment() async {
    final payProv = context.read<PaymentProvider>();

    if (payProv.selectedApp == PaymentApp.customUpi) {
      payProv.setCustomUpiId(_upiIdController.text.trim());
    }

    final success = await payProv.initiateUpiPayment(
      amount: widget.totalAmount > 0 ? widget.totalAmount : 12999.0,
    );

    if (success && mounted) {
      context.read<CartProvider>().clearCart();
    }
  }

  @override
  Widget build(BuildContext context) {
    final payProv = context.watch<PaymentProvider>();
    final amountToPay = widget.totalAmount > 0 ? widget.totalAmount : 12999.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('UPI Payment Gateway'),
        backgroundColor: const Color(0xFF2C3E50),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Amount Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2C3E50), Color(0xFF4CA1AF)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Amount Payable', style: TextStyle(color: Colors.white70, fontSize: 13)),
                      SizedBox(height: 4),
                      Text('AB Furniture & Home', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Text(
                    '₹${amountToPay.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            if (payProv.status == PaymentStatus.success) ...[
              // Success Transaction Receipt Card
              _buildSuccessCard(context, payProv),
            ] else ...[
              // UPI Options Selection
              const Text(
                'Select UPI Payment Method',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              ...payProv.availableUpiOptions.map((option) {
                final isSelected = payProv.selectedApp == option.app;
                return GestureDetector(
                  onTap: () => payProv.selectPaymentApp(option.app),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? const Color(0xFF2C3E50) : Colors.grey[300]!,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: const Color(0xFF2C3E50).withValues(alpha: 0.1),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              )
                            ]
                          : [],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                          color: isSelected ? const Color(0xFF2C3E50) : Colors.grey,
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.account_balance_wallet, color: Color(0xFF2C3E50)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                option.title,
                                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              if (option.upiHandle.isNotEmpty)
                                Text(
                                  'VPA: ${option.upiHandle}',
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),

              // Custom UPI ID Field
              if (payProv.selectedApp == PaymentApp.customUpi) ...[
                const SizedBox(height: 8),
                TextField(
                  controller: _upiIdController,
                  decoration: InputDecoration(
                    labelText: 'Enter VPA / UPI ID',
                    hintText: 'e.g. 9876543210@upi or name@okicici',
                    prefixIcon: const Icon(Icons.alternate_email),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],

              const SizedBox(height: 16),

              // Error Message Alert
              if (payProv.errorMessage != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          payProv.errorMessage!,
                          style: const TextStyle(color: Colors.red, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 24),

              // Pay Button / Progress indicator
              payProv.status == PaymentStatus.processing
                  ? const Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(color: Color(0xFF2C3E50)),
                          SizedBox(height: 12),
                          Text('Connecting to UPI Gateway... Please wait.'),
                        ],
                      ),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2C3E50),
                        minimumSize: const Size(double.infinity, 54),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: _processPayment,
                      child: Text(
                        'Pay ₹${amountToPay.toStringAsFixed(0)} via UPI',
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessCard(BuildContext context, PaymentProvider payProv) {
    final txn = payProv.lastTransaction!;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 36,
              backgroundColor: Colors.teal,
              child: Icon(Icons.check, size: 48, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              'Payment Successful!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            const SizedBox(height: 8),
            Text(
              'Thank you for your order.',
              style: TextStyle(color: Colors.grey[700]),
            ),
            const Divider(height: 32),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Transaction ID', style: TextStyle(color: Colors.grey)),
                Text(txn.transactionId, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Payment Mode', style: TextStyle(color: Colors.grey)),
                Text(txn.paymentMethod, style: const TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Amount Paid', style: TextStyle(color: Colors.grey)),
                Text('₹${txn.amount.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2C3E50))),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Date & Time', style: TextStyle(color: Colors.grey)),
                Text(
                  '${txn.timestamp.day}/${txn.timestamp.month}/${txn.timestamp.year} ${txn.timestamp.hour}:${txn.timestamp.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2C3E50),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
                  (route) => false,
                );
              },
              child: const Text('Return to Store', style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomerSupportScreen extends StatelessWidget {
  const CustomerSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Support'),
        backgroundColor: const Color(0xFF2C3E50),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Branding Banner Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2C3E50), Color(0xFF4CA1AF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2C3E50).withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Logo Circle
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      'AB',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF2C3E50),
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'AB FURNITURE & HOME',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber[700],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'COMPLETE HOME FURNITURE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: Colors.white30),
                  const SizedBox(height: 12),

                  // Categories list with emojis
                  const Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      Text('🛏 Beds', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                      Text('|', style: TextStyle(color: Colors.white38)),
                      Text('🛋 Sofas', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                      Text('|', style: TextStyle(color: Colors.white38)),
                      Text('🚪 Wardrobes', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                      Text('🍽 Dining', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                      Text('|', style: TextStyle(color: Colors.white38)),
                      Text('🪑 Office Furniture', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Contact Helpline Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.headset_mic_outlined, color: Color(0xFF2C3E50)),
                        SizedBox(width: 10),
                        Text(
                          '24/7 Helpline & Support',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal[50],
                        child: const Icon(Icons.phone, color: Colors.teal),
                      ),
                      title: const Text('Phone Helpline', style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: const Text('📞 1800-FURNITURE (Toll Free)\n📞 +91 9643589226'),
                      isThreeLine: true,
                      trailing: IconButton(
                        icon: const Icon(Icons.call, color: Color(0xFF2C3E50)),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Dialing 1800-FURNITURE...')),
                          );
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue[50],
                        child: const Icon(Icons.email_outlined, color: Colors.blue),
                      ),
                      title: const Text('Email Support', style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: const Text('support@abfurniture.com'),
                      trailing: IconButton(
                        icon: const Icon(Icons.send, color: Color(0xFF2C3E50)),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Opening email client...')),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Delivery Vehicle & Moving Banner Note Card
            Card(
              elevation: 2,
              color: Colors.amber[50],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.amber[800],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.local_shipping, color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Moving Advertisement & Delivery Fleet',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Large AB branding on both sides of our vehicles acts as a moving advertisement, showcasing complete home furniture solutions.',
                            style: TextStyle(fontSize: 12, color: Colors.black87, height: 1.4),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Request Callback Button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2C3E50),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              icon: const Icon(Icons.support_agent, color: Colors.white),
              label: const Text(
                'Request Instant Callback',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Request Callback'),
                    content: const Text(
                      'Our customer support executive will call you back on your registered phone number within 15 minutes.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2C3E50)),
                        onPressed: () {
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Callback requested! We will call you shortly.')),
                          );
                        },
                        child: const Text('Confirm', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

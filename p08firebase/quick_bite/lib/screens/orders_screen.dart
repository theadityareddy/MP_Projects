import 'package:flutter/material.dart';
import 'package:quick_bite/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> orders = [
      {
        'id': '1',
        'restaurantName': 'Tandoori Nights',
        'items': [
          {'name': 'Butter Chicken', 'quantity': 2, 'price': 299},
          {'name': 'Naan', 'quantity': 4, 'price': 40},
        ],
        'totalAmount': 758,
        'status': 'Delivered',
        'date': DateTime.now().subtract(const Duration(days: 2)),
      },
      {
        'id': '2',
        'restaurantName': 'Dosa Plaza',
        'items': [
          {'name': 'Masala Dosa', 'quantity': 1, 'price': 120},
          {'name': 'Idli Sambar', 'quantity': 2, 'price': 80},
        ],
        'totalAmount': 280,
        'status': 'Delivered',
        'date': DateTime.now().subtract(const Duration(days: 5)),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Orders',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: orders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 64,
                    color: AppTheme.onSurfaceColor.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No orders yet',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: AppTheme.onSurfaceColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              order['restaurantName'],
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: order['status'] == 'Delivered'
                                    ? Colors.green.withOpacity(0.2)
                                    : Colors.orange.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                order['status'],
                                style: GoogleFonts.poppins(
                                  color: order['status'] == 'Delivered'
                                      ? Colors.green
                                      : Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ...order['items'].map<Widget>((item) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${item['quantity']}x ${item['name']}',
                                  style: GoogleFonts.poppins(
                                    color: AppTheme.onSurfaceColor.withOpacity(0.7),
                                  ),
                                ),
                                Text(
                                  '₹${item['price'] * item['quantity']}',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ordered on ${DateFormat('MMM dd, yyyy').format(order['date'])}',
                              style: GoogleFonts.poppins(
                                color: AppTheme.onSurfaceColor.withOpacity(0.7),
                              ),
                            ),
                            Text(
                              '₹${order['totalAmount']}',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
} 
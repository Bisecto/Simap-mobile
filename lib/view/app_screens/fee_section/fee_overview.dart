import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/fee_bloc/fee_bloc.dart';
import '../../../bloc/fee_bloc/fee_event.dart';
import '../../../bloc/fee_bloc/fee_state.dart';
import '../../../model/fee/fee_item.dart';
import 'fee_detail.dart';


class FeeOverviewScreen extends StatelessWidget {
  const FeeOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Fees'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.orange[400],
            child: const Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: BlocBuilder<FeeBloc, FeeState>(
        builder: (context, state) {
          if (state is FeeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FeeError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<FeeBloc>().add(LoadFees()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is FeeLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<FeeBloc>().add(LoadFees());
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // School Fees Header Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.pink[300]!, Colors.pink[400]!],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Your School Fees',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Manage your fees, make payments,\nand track your payment history',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '© ${DateTime.now().year} Student Third Term',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Image.asset(
                            'assets/payment_icon.png', // Add your payment icon
                            width: 60,
                            height: 60,
                            errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.payment, color: Colors.white, size: 60),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Total Amount Paid
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.green[700],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Total Amount Paid in Fees',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '₦${state.totalPaid.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.bar_chart, size: 24),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Fee Items
                    _buildFeeItem(
                      context,
                      icon: Icons.school,
                      iconColor: Colors.blue,
                      title: 'Total fees due',
                      amount: '₦${state.totalDue.toStringAsFixed(0)}',
                      onTap: () => _showFeesList(context, state.fees.where((f) => f.status == PaymentStatus.pending).toList()),
                    ),

                    const SizedBox(height: 8),

                    _buildFeeItem(
                      context,
                      icon: Icons.pending,
                      iconColor: Colors.orange,
                      title: 'Pending Payment',
                      amount: '${state.fees.where((f) => f.status == PaymentStatus.pending).length}',
                      onTap: () => _showFeesList(context, state.fees.where((f) => f.status == PaymentStatus.pending).toList()),
                    ),

                    const SizedBox(height: 24),

                    // Payment History Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Payment History',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Text('Status', style: TextStyle(fontSize: 12)),
                              const SizedBox(width: 4),
                              Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey[600]),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Search Bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey[500]),
                          const SizedBox(width: 8),
                          Text(
                            'Search by reference',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Payment History List
                    ...state.paymentHistory.map((transaction) =>
                        PaymentHistoryItem(transaction: transaction),
                    ),
                  ],
                ),
              ),
            );
          }

          return const Center(child: Text('No data available'));
        },
      ),
    );
  }

  Widget _buildFeeItem(
      BuildContext context, {
        required IconData icon,
        required Color iconColor,
        required String title,
        required String amount,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              amount,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _showFeesList(BuildContext context, List<FeeItem> fees) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Pending Fees',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...fees.map((fee) => ListTile(
              title: Text(fee.type),
              subtitle: Text('${fee.session} - ${fee.term}'),
              trailing: Text('₦${fee.amount.toStringAsFixed(0)}'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FeeDetailScreen(fee: fee),
                  ),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}

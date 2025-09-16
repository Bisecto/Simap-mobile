import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
            print(state.fees[0].status);
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
                                  '© ${DateTime.now().year} Student ${state.activeTerm} term',
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
                      onTap: () { _showFeesList(context, state.fees.where((f) => f.paymentStatus == PaymentStatus.pending).toList());},
                    ),

                    const SizedBox(height: 8),

                    _buildFeeItem(
                      context,
                      icon: Icons.pending,
                      iconColor: Colors.orange,
                      title: 'Pending Payment',
                      amount: '${state.fees.where((f) => f.paymentStatus == PaymentStatus.pending).length}',
                      onTap: () { _showFeesList(context, state.fees.where((f) => f.paymentStatus == PaymentStatus.pending).toList());},
                    ),

                    const SizedBox(height: 24),

                    // Payment History Header
                    const Text(
                      'Payment History',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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
    print(["56789"]);
    print(fees);
    print(fees);
    print(fees);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Important: allows custom height
      backgroundColor: Colors.transparent,
      builder: (context) => _buildFeesBottomSheet(context, fees),
    );
  }

  Widget _buildFeesBottomSheet(BuildContext context, List<FeeItem> fees) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7, // 70% of screen height
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 8),
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text(
                  'Pending Fees',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.grey[100],
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Fees list
          Expanded(
            child: fees.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: fees.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final fee = fees[index];
                return buildFeeItem(context, fee);
              },
            ),
          ),

          // Summary footer
          if (fees.isNotEmpty) _buildSummaryFooter(fees),
        ],
      ),
    );
  }

  Widget buildFeeItem(BuildContext context, FeeItem fee) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FeeDetailScreen(fee: fee),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Fee icon
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getFeeTypeColor(fee.feeType).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getFeeTypeIcon(fee.feeType),
                    color: _getFeeTypeColor(fee.feeType),
                    size: 20,
                  ),
                ),

                const SizedBox(width: 12),

                // Fee details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fee.fee, // Use fee instead of type
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.school_outlined,
                            size: 14,
                            color: Colors.grey[500],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${fee.session} • ${fee.term}',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      if (fee.dueDate != null) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 14,
                              color: fee.isOverdue ? Colors.red : Colors.orange,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              fee.isOverdue
                                  ? 'Overdue'
                                  : 'Due ${_formatDueDate(fee.dueDate!)}',
                              style: TextStyle(
                                fontSize: 12,
                                color: fee.isOverdue ? Colors.red : Colors.orange,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),

                // Amount and status
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '₦${NumberFormat('#,##0').format(fee.outstanding)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: fee.isOverdue ? Colors.red : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (fee.paid > 0)
                      Text(
                        'Paid: ₦${NumberFormat('#,##0').format(fee.paid)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: fee.isOverdue
                            ? Colors.red.withOpacity(0.1)
                            : Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        fee.isOverdue ? 'OVERDUE' : 'PENDING',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: fee.isOverdue ? Colors.red : Colors.orange,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 4),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey[400],
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryFooter(List<FeeItem> fees) {
    final totalOutstanding = fees.fold<double>(0, (sum, fee) => sum + fee.outstanding);
    final totalPaid = fees.fold<double>(0, (sum, fee) => sum + fee.paid);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Outstanding',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                '₦${NumberFormat('#,##0').format(totalOutstanding)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          if (totalPaid > 0) ...[
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Paid',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  '₦${NumberFormat('#,##0').format(totalPaid)}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.green[600],
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: totalOutstanding > 0 ? () => _handlePayAllFees(fees) : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Pay All Outstanding (₦${NumberFormat('#,##0').format(totalOutstanding)})',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 64,
            color: Colors.green[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No Pending Fees!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'All your fees are up to date',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

// Helper methods
  Color _getFeeTypeColor(String feeType) {
    switch (feeType.toLowerCase()) {
      case 'tuition':
        return Colors.blue;
      case 'books':
      case 'library':
        return Colors.green;
      case 'transport':
        return Colors.orange;
      case 'uniform':
        return Colors.purple;
      case 'exam':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getFeeTypeIcon(String feeType) {
    switch (feeType.toLowerCase()) {
      case 'tuition':
        return Icons.school;
      case 'books':
      case 'library':
        return Icons.book;
      case 'transport':
        return Icons.directions_bus;
      case 'uniform':
        return Icons.checkroom;
      case 'exam':
        return Icons.quiz;
      default:
        return Icons.payment;
    }
  }

  String _formatDueDate(DateTime dueDate) {
    final now = DateTime.now();
    final difference = dueDate.difference(now).inDays;

    if (difference == 0) {
      return 'today';
    } else if (difference == 1) {
      return 'tomorrow';
    } else if (difference > 1) {
      return 'in $difference days';
    } else {
      return '${difference.abs()} days ago';
    }
  }

  void _handlePayAllFees(List<FeeItem> fees) {
    // Handle pay all fees logic
    print('Paying all fees: ${fees.length} items');
  }

}

// lib/screens/fee_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/fee_bloc/fee_bloc.dart';
import '../../../bloc/fee_bloc/fee_event.dart';
import '../../../bloc/fee_bloc/fee_state.dart';
import '../../../model/fee/fee_item.dart';
import '../../../model/fee/payment_transaction.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
class FeeDetailScreen extends StatelessWidget {
  final FeeItem fee;

  const FeeDetailScreen({super.key, required this.fee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('My Fees'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener<FeeBloc, FeeState>(
        listener: (context, state) {
          if (state is PaymentInitiated) {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => PaymentWebViewScreen(
            //       paymentUrl: state.paymentUrl,
            //       fee: state.fee,
            //     ),
            //   ),
            // );
          }

          if (state is FeeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              // Fee Details Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fee.type,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Session ${fee.session}',
                            style: TextStyle(
                              color: Colors.blue[700],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            fee.term,
                            style: TextStyle(
                              color: Colors.green[700],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '₦${fee.amount.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        BlocBuilder<FeeBloc, FeeState>(
                          builder: (context, state) {
                            final isLoading = state is FeeLoading;
                            return ElevatedButton(
                              onPressed: isLoading ? null : () {
                                context.read<FeeBloc>().add(InitiatePayment(fee));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 0,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (isLoading)
                                    const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation(Colors.white),
                                      ),
                                    )
                                  else
                                    const Text(
                                      'Pay',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.arrow_forward, size: 18),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Please pay on time',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Payment Information
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Payment Information',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.info_outline,
                            color: Colors.blue[700],
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Powered by Credo • Secure and reliable payments',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Payment Options
                    _buildPaymentOption(
                      icon: Icons.credit_card,
                      iconColor: Colors.blue,
                      title: 'Online Payment',
                      description: 'Pay securely with your debit card, bank transfer,\nor USSD',
                    ),

                    const SizedBox(height: 16),

                    _buildPaymentOption(
                      icon: Icons.account_balance_wallet,
                      iconColor: Colors.green,
                      title: 'Multiple Options',
                      description: 'Choose from various payment methods for\nyour convenience',
                    ),

                    const SizedBox(height: 16),

                    _buildPaymentOption(
                      icon: Icons.receipt_long,
                      iconColor: Colors.purple,
                      title: 'Instant Confirmation',
                      description: 'Get immediate payment confirmation and\nreceipts',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: iconColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




class PaymentHistoryItem extends StatelessWidget {
  final PaymentTransaction transaction;
  final VoidCallback? onTap;
  final VoidCallback? onReceiptTap;

  const PaymentHistoryItem({
    super.key,
    required this.transaction,
    this.onTap,
    this.onReceiptTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Main transaction info
                Row(
                  children: [
                    // Status Icon with animation
                    Hero(
                      tag: 'transaction_${transaction.id}',
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _getStatusColor(transaction.status),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: _getStatusColor(transaction.status).withOpacity(0.3),
                              spreadRadius: 0,
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          _getStatusIcon(transaction.status),
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Transaction Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Fee description
                          Text(
                            _getTransactionDescription(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 6),

                          // Transaction ID with copy functionality
                          GestureDetector(
                            onTap: _copyTransactionId,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.receipt_outlined,
                                  size: 14,
                                  color: Colors.grey[500],
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    transaction.transactionId,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.copy,
                                  size: 12,
                                  color: Colors.grey[400],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Amount
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '₦${NumberFormat('#,##0').format(transaction.amount)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _getAmountColor(),
                          ),
                        ),
                        const SizedBox(height: 4),
                        _buildStatusChip(),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Additional details row
                Row(
                  children: [
                    // Payment method
                    _buildInfoChip(
                      icon: Icons.payment,
                      text: transaction.paymentMethod,
                      color: Colors.blue,
                    ),

                    const SizedBox(width: 8),

                    // Date
                    _buildInfoChip(
                      icon: Icons.access_time,
                      text: _formatDateTime(transaction.datePaid),
                      color: Colors.grey,
                    ),

                    const Spacer(),

                    // Receipt button (if available)
                    if (transaction.receiptUrl.isNotEmpty)
                      _buildReceiptButton(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor(transaction.status).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _getStatusColor(transaction.status).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        _getDisplayStatus(),
        style: TextStyle(
          color: _getStatusColor(transaction.status),
          fontSize: 10,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onReceiptTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.green.withOpacity(0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.download_outlined,
                size: 14,
                color: Colors.green,
              ),
              SizedBox(width: 4),
              Text(
                'Receipt',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTransactionDescription() {
    if (transaction.fees.isNotEmpty) {
      return transaction.fees.map((fee) => fee.fee).join(', ');
    }
    return transaction.description;
  }

  String _getDisplayStatus() {
    switch (transaction.status.toLowerCase()) {
      case 'successful and completed':
        return 'COMPLETED';
      case 'successful':
        return 'SUCCESS';
      case 'failed':
        return 'FAILED';
      case 'pending':
        return 'PENDING';
      case 'processing':
        return 'PROCESSING';
      default:
        return transaction.status.toUpperCase();
    }
  }

  Color _getAmountColor() {
    switch (transaction.status.toLowerCase()) {
      case 'successful':
      case 'successful and completed':
        return Colors.green[700]!;
      case 'failed':
        return Colors.red[700]!;
      default:
        return Colors.black87;
    }
  }

  void _copyTransactionId() {
    Clipboard.setData(ClipboardData(text: transaction.transactionId));
    // You might want to show a snackbar here
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase().trim()) {
      case 'successful':
      case 'successful and completed':
      case 'completed':
        return Colors.green;
      case 'failed':
      case 'error':
        return Colors.red;
      case 'pending':
      case 'processing':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase().trim()) {
      case 'successful':
      case 'successful and completed':
      case 'completed':
        return Icons.check_circle_rounded;
      case 'failed':
      case 'error':
        return Icons.error_rounded;
      case 'pending':
        return Icons.schedule_rounded;
      case 'processing':
        return Icons.sync_rounded;
      default:
        return Icons.help_outline_rounded;
    }
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';

    final now = DateTime.now();
    final difference = now.difference(dateTime);

    // Show relative time for recent transactions
    if (difference.inDays == 0) {
      return 'Today, ${DateFormat('h:mm a').format(dateTime)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday, ${DateFormat('h:mm a').format(dateTime)}';
    } else if (difference.inDays < 7) {
      return DateFormat('E, h:mm a').format(dateTime); // Mon, 2:30 PM
    } else {
      return DateFormat('MMM d, h:mm a').format(dateTime); // Sep 14, 2:30 PM
    }
  }
}

// Enhanced usage example
class PaymentHistoryList extends StatelessWidget {
  final List<PaymentTransaction> transactions;
  final Function(PaymentTransaction)? onTransactionTap;
  final Function(PaymentTransaction)? onReceiptDownload;

  const PaymentHistoryList({
    super.key,
    required this.transactions,
    this.onTransactionTap,
    this.onReceiptDownload,
  });

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return PaymentHistoryItem(
          transaction: transaction,
          onTap: () => onTransactionTap?.call(transaction),
          onReceiptTap: () => onReceiptDownload?.call(transaction),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No Payment History',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your payment transactions will appear here',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
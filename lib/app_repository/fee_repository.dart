import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/fee/fee_item.dart';
import '../model/fee/payment_transaction.dart';

class FeeRepository {
  //final String baseUrl;
  final http.Client _httpClient;

  FeeRepository({
   // required this.baseUrl,
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();
  String baseUrl='https://uhs.myeduportal.net';

  // Mock data for demo - replace with actual API calls
  Future<List<FeeItem>> getFees() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock data matching your UI
    return [
      FeeItem(
        id: '1',
        type: 'Tuition Fee',
        amount: 15000,
        session: '2023/2024',
        term: 'First Term',
        status: PaymentStatus.pending,
        reference: 'Xmtw00ac7V14gqH3182V',
        dueDate: DateTime.now().add(const Duration(days: 30)),
      ),
      FeeItem(
        id: '2',
        type: 'Books Payment',
        amount: 7500,
        session: '2023/2024',
        term: 'First Term',
        status: PaymentStatus.pending,
        reference: 'RhJpUrCN',
        dueDate: DateTime.now().add(const Duration(days: 15)),
      ),
    ];
  }

  Future<List<PaymentTransaction>> getPaymentHistory() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      PaymentTransaction(
        id: '1',
        reference: 'Xmtw00ac7V14gqH3182V',
        amount: 15000,
        status: PaymentStatus.successful,
        date: DateTime(2025, 7, 7, 10, 45),
        description: 'Tuition Fee',
        paymentId: '#PAY_20250707172133_4EA6E4B2',
      ),
      PaymentTransaction(
        id: '2',
        reference: 'RhJpUrCN',
        amount: 7500,
        status: PaymentStatus.failed,
        date: DateTime(2025, 7, 7, 11, 45),
        description: 'Books Payment',
        paymentId: '#PAY_20250707174533_5FB7F5C3',
      ),
    ];
  }

  Future<String> initiatePayment(FeeItem fee) async {
    // Simulate API call to payment gateway
    await Future.delayed(const Duration(seconds: 2));

    // Return mock payment URL - replace with actual payment gateway URL
    return 'https://checkout.paystack.com/v3/${fee.reference}';
  }

  Future<PaymentTransaction> verifyPayment(String reference) async {
    await Future.delayed(const Duration(seconds: 1));

    // Mock successful payment verification
    return PaymentTransaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      reference: reference,
      amount: 15000,
      status: PaymentStatus.successful,
      date: DateTime.now(),
      description: 'Payment',
      paymentId: '#PAY_${DateTime.now().millisecondsSinceEpoch}_${reference.substring(0, 8).toUpperCase()}',
    );
  }
}

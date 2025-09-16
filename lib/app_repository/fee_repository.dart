import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/fee/fee_item.dart';
import '../model/fee/fee_summary.dart';
import '../model/fee/payment_transaction.dart';

class FeeRepository {
  //final String baseUrl;
  final http.Client _httpClient;

  FeeRepository({
   // required this.baseUrl,
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();
  String baseUrl='https://demo.myeduportal.net/endpoint/get-student-fees/';
  String feehistory='https://demo.myeduportal.net/endpoint/payment-history/';


  // Mock data for demo - replace with actual API calls
  Future<FeesResponse> getFees(String token) async {
    try {
      final headers = {
        'Authorization': 'JWT $token',
        'Content-Type': 'application/json',
      };

      var response = await http.get(
        Uri.parse(baseUrl),
        headers: headers,
      );
      print('API URI: $baseUrl');
      print('API Response: ${response.body}');
      print('Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return FeesResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load fees. Status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching fees: $error');
      throw Exception('Failed to fetch fees: $error');
    }
  }
  Future<PaymentHistoryResponse> getPaymentHistory({
    required String token,
    int page = 1,
    int perPage = 20,
  }) async {
    try {
      final headers = {
        'Authorization': 'JWT $token',
        'Content-Type': 'application/json',
      };
      final uri = Uri.parse(feehistory)
          .replace(queryParameters: {
        'page': page.toString(),
        'per_page': perPage.toString(),
      });
      var response = await http.get(
        uri,
        headers: headers,
      );
      print('API URI: $feehistory');
      print('API Response: ${response.body}');
      print('Status Code: ${response.statusCode}');
      print('Payment History API Response: ${response.body}');
      print('Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return PaymentHistoryResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load payment history. Status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching payment history: $error');
      throw Exception('Failed to fetch payment history: $error');
    }
  }
  Future<String> initiatePayment(FeeItem fee) async {
    // Simulate API call to payment gateway
    await Future.delayed(const Duration(seconds: 2));

    // Return mock payment URL - replace with actual payment gateway URL
    return 'https://checkout.paystack.com/v3/';
  }

  // Future<PaymentTransaction> verifyPayment(String reference) async {
  //   await Future.delayed(const Duration(seconds: 1));
  //
  //   // Mock successful payment verification
  //   return PaymentTransaction(
  //     id: DateTime.now().millisecondsSinceEpoch.toString(),
  //     reference: reference,
  //     amount: 15000,
  //     status: PaymentStatus.successful,
  //     date: DateTime.now(),
  //     description: 'Payment',
  //     paymentId: '#PAY_${DateTime.now().millisecondsSinceEpoch}_${reference.substring(0, 8).toUpperCase()}',
  //   );
  // }
}

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/store_model/store.dart';
import '../res/shared_preferenceKey.dart';
import '../utills/shared_preferences.dart';

class StoreService {


  StoreService();

  Future<StoreResponse> getHomeProducts() async {
    String accessToken =
    await SharedPref.getString(SharedPreferenceKey().accessTokenKey);
    final response = await http.get(
      Uri.parse('http://uhs.myeduportal.net/endpoint/store/home'),
      headers: {
        'Authorization': 'JWT $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return StoreResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load home products');
    }
  }

  Future<StoreResponse> getRecommendedProducts() async {
    String accessToken =
    await SharedPref.getString(SharedPreferenceKey().accessTokenKey);
    print(accessToken);
    final response = await http.get(
      Uri.parse('http://uhs.myeduportal.net/endpoint/store/recommended-for-you'),
      headers: {
        'Authorization': 'JWT $accessToken',
        'Content-Type': 'application/json',
      },
    );
print(response.body);
    if (response.statusCode == 200) {
      return StoreResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load recommended products');
    }
  }
}

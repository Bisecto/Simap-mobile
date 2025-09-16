import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/store_model/store.dart';
import '../res/shared_preferenceKey.dart';
import '../utills/shared_preferences.dart';

class StoreService {
  StoreService();

  Future<StoreResponse> getHomeProducts() async {
    // Get saved values
    String accessToken =
    await SharedPref.getString(SharedPreferenceKey().accessTokenKey);
    String sessionId =
    await SharedPref.getString(SharedPreferenceKey().sessionIdKey);
    String csrfToken =
    await SharedPref.getString(SharedPreferenceKey().csrftokenKey);

    final response = await http.get(
      Uri.parse('https://demo.myeduportal.net/endpoint/store/home'),
      headers: {
        'Authorization': 'JWT $accessToken',
        'Content-Type': 'application/json',
        // Add cookies just like Postman
        'Cookie': 'csrftoken=$csrfToken; sessionid=$sessionId',
      },
    );

    print("ACCESS TOKEN: $accessToken");
    print("CSRF TOKEN: $csrfToken");
    print("SESSION ID: $sessionId");
    print('https://demo.myeduportal.net/endpoint/store/home');
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      return StoreResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load home products');
    }
  }

}

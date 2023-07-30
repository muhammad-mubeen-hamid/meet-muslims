import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:meet_muslims_client/models/PreCheckEmail.dart';
import 'package:meet_muslims_client/models/error.dart';

class UserProvider with ChangeNotifier {
  late String _id;
  late String _email;

  String get id => _id;

  String get email => _email;

  void setUser(String id, String email) {
    _id = id;
    _email = email;
    notifyListeners();
  }

  Future<bool> emailAlreadyExists(String username) async {
    return http.post(
      Uri.parse('http://192.168.3.62:3000/preEmailCheck'),
      body: jsonEncode({
        'username': username,
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).then((response) {
      // HTTP 200 - OK
      if (response.statusCode == 200) {
        final data = PreCheckEmailResponse.fromJson(jsonDecode(response.body));
        if (data.username == null) return false;
        return true;
      }
      // HTTP 404 - NOT FOUND
      if (response.statusCode == 404) {
        return false;
      }

      return false;
    });
  }

  Future<AppNetworkResponse> registerUser(String username, String password, String phoneNumber) async {
    return http.post(
        Uri.parse(
          'http://192.168.3.62:3000/signup',
        ),
        body: jsonEncode({
          'username': username,
          'password': password,
          'phone_number': phoneNumber,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        }).then((response) {
      // HTTP 200 - OK
      if (response.statusCode == 200) {
        return AppNetworkResponse(
          message: 'User registered successfully',
          httpCode: 200,
        );
      }
      if (response.statusCode == 400) {
        return AppNetworkResponse(
          message: 'User already exists',
          httpCode: 400,
        );
      }
      // HTTP 404 - NOT FOUND
      if (response.statusCode == 404) {
        return AppNetworkResponse(
          message: 'User not found',
          httpCode: 404,
        );
      }
      // default case
      return AppNetworkResponse(
        message: 'Something went wrong',
        httpCode: 500,
      );
    });
  }
}

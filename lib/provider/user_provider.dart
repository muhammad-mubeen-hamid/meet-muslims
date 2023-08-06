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

  Future<AppNetworkResponse> registerUser(
      String username, String password, String phoneNumber) async {
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

  Future<AppNetworkResponse> requestPhoneOTP(String username) async {
    final response =
        await http.post(Uri.parse('http://192.168.3.62:3000/requestPhoneOTP'),
            body: jsonEncode({
              'username': username,
            }),
            headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        });

    // HTTP 200 - OK
    if (response.statusCode == 200) {
      return AppNetworkResponse(
        message: 'OTP request successfully',
        httpCode: 200,
      );
    }
    // HTTP 400 - BAD REQUEST
    if (response.statusCode == 400) {
      return AppNetworkResponse(
        message: 'Unable to request OTP',
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
  }

  Future<AppNetworkResponse> validatePhoneOTP(String username, String otp) async {
    final response =
        await http.post(Uri.parse('http://192.168.3.62:3000/validatePhoneOTP'),
            body: jsonEncode({
              'username': username,
              'otp': otp,
            }),
            headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        });

    // HTTP 200 - OK
    if (response.statusCode == 200) {
      return AppNetworkResponse(
        message: 'OTP validated successfully',
        httpCode: 200,
      );
    }
    // HTTP 400 - BAD REQUEST
    if (response.statusCode == 400) {
      return AppNetworkResponse(
        message: 'The entered OTP is invalid. Please try again later',
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
      message: 'Something went wrong. Please try again later.',
      httpCode: 500,
    );
  }
}

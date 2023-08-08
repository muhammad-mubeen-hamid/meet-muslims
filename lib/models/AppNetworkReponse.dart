class AppNetworkResponse {
  final String message;
  final int httpCode;

  AppNetworkResponse({
    required this.message,
    required this.httpCode,
  });

  factory AppNetworkResponse.fromJson(Map<String, dynamic> json) {
    return AppNetworkResponse(
      message: json['message'],
      httpCode: json['httpCode'],
    );
  }
}
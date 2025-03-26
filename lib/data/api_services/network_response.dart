class NetworkResponse {
  late final bool isSuccess;
  late final int statusCode;
  late final Map<String, dynamic>? data;
  late final String errorMessage;

  NetworkResponse(
      {required this.isSuccess,
      required this.statusCode,
      this.data,
      this.errorMessage = "Something wrong"});
}

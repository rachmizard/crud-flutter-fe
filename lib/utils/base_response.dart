class BaseResponse<T> {
  bool? status;
  int? code;
  T? data;
  String? message;

  BaseResponse({this.status, this.code, this.data, this.message});

  factory BaseResponse.fromJson(Map json) {
    return BaseResponse(
        status: json['status'],
        code: json['code'],
        data: json['data'] as T,
        message: json['message']);
  }
}

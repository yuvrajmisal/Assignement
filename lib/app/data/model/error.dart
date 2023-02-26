class ErrorModel {
  String? timestamp;
  dynamic status;
  String? message;
  String? debugMessage;
  String? code;
  String? error;
  String? error_description;

  ErrorModel({
    this.timestamp,
    this.status,
    this.message,
    this.debugMessage,
    this.code,
    this.error,
    this.error_description,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> map) {
    return ErrorModel(
      timestamp: map.containsKey('timestamp') ? map['timestamp'] : null,
      status: map.containsKey('status') ? map['status'] : null,
      message: map.containsKey('message') ? map['message'] : null,
      debugMessage:
          map.containsKey('debugMessage') ? map['debugMessage'] : null,
      code: map.containsKey('code') ? map['code'] : null,
      error: map.containsKey('error') ? map['error'] : null,
      error_description: map.containsKey('error_description')
          ? map['error_description']
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'status': status,
      'message': message,
      'debugMessage': debugMessage,
      'code': code,
      'error': error,
      'error_description': error_description,
    };
  }
}

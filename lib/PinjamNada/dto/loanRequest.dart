class RequestLoan {
  final int requestId;
  final String message;
  final int userId;
  final String fullName;
  final String requestDate;
  final String phone;

  RequestLoan({
    required this.requestId,
    required this.message,
    required this.userId,
    required this.fullName,
    required this.requestDate,
    required this.phone,
  });

  factory RequestLoan.fromJson(Map<String, dynamic> json) {
    return RequestLoan(
      requestId: json['request_id'],
      message: json['message'],
      userId: json['user_id'],
      fullName: json['full_name'],
      requestDate: json['request_date'], // Konversi string tanggal menjadi DateTime
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'request_id': requestId,
      'message': message,
      'user_id': userId,
      'full_name': fullName,
      'request_date': requestDate, // Konversi DateTime ke string ISO 8601
      'phone': phone,
    };
  }
}
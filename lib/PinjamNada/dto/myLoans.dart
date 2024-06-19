class MyLoans {
  final String requestDate;
  final String location;
  final String fullName;
  final String phone;
  final int source;

  // Constructor untuk inisialisasi objek dari data yang diterima
  MyLoans({
    required this.requestDate,
    required this.location,
    required this.fullName,
    required this.phone,
    required this.source,
  });

  // Factory method untuk membuat objek MyLoan dari Map
  factory MyLoans.fromJson(Map<String, dynamic> json) {
    return MyLoans(
      requestDate: json['request_date'] ?? '',
      location: json['location'] ?? '',
      fullName: json['full_name'] ?? '',
      phone: json['phone'] ?? '',
      source: json['source'] ?? 0,
    );
  }

    Map<String, dynamic> toJson() {
    return {
      'request_date': requestDate,
      'location': location,
      'full_name': fullName,
      'phone': fullName,
      'source': source, 

    };
  }
}
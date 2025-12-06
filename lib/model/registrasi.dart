class Registrasi {
  final int? code;
  final bool status;
  final String? message;

  Registrasi({
    this.code,
    required this.status,
    this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'message': message,
    };
  }

  factory Registrasi.fromJson(Map<String, dynamic> json) {
    return Registrasi(
      code: json['code'],
      status: json['status'] ?? false,
      message: json['data']?.toString() ?? json['message']?.toString(),
    );
  }
}
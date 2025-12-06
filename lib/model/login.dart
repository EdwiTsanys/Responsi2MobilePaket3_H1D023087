class Login {
  final int? code;
  final bool status;
  final String? message;
  final LoginData? data;

  Login({
    this.code,
    required this.status,
    this.message,
    this.data,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      code: json['code'],
      status: json['status'] ?? false,
      message: json['data'] is String ? json['data'] : null,
      data: json['data'] is Map<String, dynamic> ? LoginData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class LoginData {
  final String? token;
  final UserData? user;

  LoginData({this.token, this.user});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      token: json['token'],
      user: json['user'] != null ? UserData.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user?.toJson(),
    };
  }
}

class UserData {
  final String? id;
  final String? username;
  final String? email;

  UserData({this.id, this.username, this.email});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id']?.toString(),
      username: json['username'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
    };
  }
}
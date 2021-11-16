class Login {
  String email;
  String password;

  Login({required this.email, required this.password});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      email: json['username'],
      password: json['password'],
    );
  }
}

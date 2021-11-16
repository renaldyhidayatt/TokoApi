class Register {
  String nama;
  String email;
  String password;

  Register({required this.nama, required this.email, required this.password});

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      nama: json['nama'],
      email: json['email'],
      password: json['password'],
    );
  }
}

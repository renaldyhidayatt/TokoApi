class Member {
  final int? id;
  final String nama;
  final String email;

  Member({this.id, required this.nama, required this.email});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      nama: json['nama'],
      email: json['email'],
    );
  }
}

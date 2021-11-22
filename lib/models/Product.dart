import 'dart:convert';

class Product {
  int? id;
  int kodeproduct;
  String namaproduct;
  int hargaproduct;

  Product({
    this.id,
    required this.kodeproduct,
    required this.namaproduct,
    required this.hargaproduct,
  });

  factory Product.fromMap(Map<String, dynamic> json) => Product(
      id: json["id"],
      kodeproduct: json['kode_product'],
      namaproduct: json["nama_product"],
      hargaproduct: json["harga_product"]);
}

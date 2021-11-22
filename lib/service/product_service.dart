import 'dart:convert';

import "package:http/http.dart" as http;

import 'package:coba_aja/models/Product.dart';

class ProductService {
  final String apiUrl = "http://localhost:8000";

  Future<List<Product>> getProduct() async {
    final response = await http.get(Uri.parse('${this.apiUrl}/products'),
        headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      print(response.body);

      return parsed.map<Product>((json) => Product.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load Employee');
    }
  }

  Future<Product> createProduct(Product product) async {
    Map data = {
      "kode_product": product.kodeproduct,
      "nama_product": product.namaproduct,
      "harga_product": product.hargaproduct
    };

    print(data);

    final response = await http.post(
      Uri.parse('${this.apiUrl}/products/create'),
      body: jsonEncode(data),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      return Product.fromMap(json.decode(response.body));
    } else {
      throw Exception('Failed to create employee');
    }
  }

  Future<void> updateProduct(String id, Product product) {
    Map data = {
      "kode_product": product.kodeproduct,
      "nama_product": product.namaproduct,
      "harga_product": product.hargaproduct
    };

    return http.put(
      Uri.parse('${this.apiUrl}/products/update/$id'),
      body: jsonEncode(data),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
  }

  Future<void> deleteProduct(String id) async {
    final response =
        await http.delete(Uri.parse('${this.apiUrl}/products/$id'));
    if (response.statusCode == 200) {
      print("Delete");
    } else {
      throw "Failed to delete a Employee";
    }
  }
}

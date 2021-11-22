import 'package:coba_aja/models/Product.dart';
import 'package:coba_aja/ui/product_detail.dart';
import 'package:flutter/material.dart';

class ItemProduct extends StatelessWidget {
  final Product product;

  ItemProduct({required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        product.namaproduct,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(top: 8),
        child: Text(
          product.hargaproduct.toString(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetail(product: product)));
      },
    );
  }
}

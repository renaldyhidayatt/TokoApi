import 'package:coba_aja/models/Product.dart';
import 'package:coba_aja/service/product_service.dart';
import 'package:coba_aja/ui/home_page.dart';
import 'package:coba_aja/ui/product_form.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  final Product product;

  ProductDetail({required this.product});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final ProductService productService = ProductService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.namaproduct),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              widget.product.kodeproduct.toString(),
              style: TextStyle(fontSize: 20),
            ),
            Text(
              widget.product.namaproduct,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              widget.product.hargaproduct.toString(),
              style: TextStyle(fontSize: 20),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        RaisedButton(
          child: Text('Edit'),
          color: Colors.blue,
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                        ProductForm(product: widget.product)));
          },
        ),
        RaisedButton(
            child: Text('Hapus'),
            color: Colors.red,
            onPressed: () => confirmHapus()),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text("Anda yakin ingin menghapus data ini?"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text("Hapus"),
          color: Colors.red,
          onPressed: () {
            print("Delete");
            productService.deleteProduct(widget.product.id.toString());
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        new RaisedButton(
          child: new Text("Batal"),
          color: Colors.green,
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}

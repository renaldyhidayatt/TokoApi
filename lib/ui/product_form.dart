import 'package:coba_aja/models/Product.dart';
import 'package:coba_aja/service/product_service.dart';
import 'package:coba_aja/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductForm extends StatefulWidget {
  final Product? product;
  ProductForm({this.product});
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  final ProductService productService = ProductService();
  bool _isLoading = false;
  String judul = "Tambah Product";
  String tombolSubmit = "simpan";

  final _kodeProductController = TextEditingController();
  final _namaProductController = TextEditingController();
  final _hargaProductController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.product != null) {
      _kodeProductController.text = widget.product!.kodeproduct.toString();
      _namaProductController.text = widget.product!.namaproduct;
      _hargaProductController.text = widget.product!.hargaproduct.toString();
      judul = "Update Product";
      tombolSubmit = "update";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(children: [
                _kodeProductTextField(),
                _namaProductTextField(),
                _hargaProductTextField(),
                _submitButton(),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _kodeProductTextField() {
    return TextFormField(
      controller: _kodeProductController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: "Kode Product",
          hintText: "Masukkan Kode Product",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      validator: (value) {
        if (value!.isEmpty) {
          return "Kode Product tidak boleh kosong";
        }
        return null;
      },
    );
  }

  Widget _namaProductTextField() {
    return TextFormField(
      maxLines: 1,
      controller: _namaProductController,
      decoration: InputDecoration(
          labelText: "Nama Product",
          hintText: "Masukkan Nama Product",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Product tidak boleh kosong";
        }
        return null;
      },
    );
  }

  Widget _hargaProductTextField() {
    return TextFormField(
      controller: _hargaProductController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: "Harga Product",
          hintText: "Masukkan Harga Product",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      validator: (value) {
        if (value!.isEmpty) {
          return "Harga Product tidak boleh kosong";
        }
        return null;
      },
    );
  }

  Widget _submitButton() {
    return RaisedButton(
      color: Colors.blue,
      child: Text(
        tombolSubmit,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          if (tombolSubmit == "simpan") {
            productService.createProduct(Product(
                kodeproduct: int.parse(_kodeProductController.text),
                namaproduct: _namaProductController.text,
                hargaproduct: int.parse(_hargaProductController.text)));
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          } else {
            productService.updateProduct(
                widget.product!.id.toString(),
                Product(
                    kodeproduct: int.parse(_kodeProductController.text),
                    namaproduct: _namaProductController.text,
                    hargaproduct: int.parse(_hargaProductController.text)));
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          }
        }
      },
    );
  }
}

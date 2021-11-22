import 'dart:convert';

import 'package:coba_aja/helpers/user_info.dart';
import 'package:coba_aja/models/Product.dart';
import 'package:coba_aja/models/member.dart';

import 'package:coba_aja/service/member_service.dart';
import 'package:coba_aja/service/product_service.dart';
import 'package:coba_aja/ui/Login_page.dart';
import 'package:coba_aja/ui/product_form.dart';
import 'package:coba_aja/widget/ItemProduct.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences sharedPreferences;

  ProductService productService = ProductService();
  MemberService memberService = MemberService();

  UserInfo userInfo = UserInfo();

  late final String nama;
  late final String email;

  late Future<Member> member;
  late Future<List<Product>> products;
  // String nama;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    fethcId();
    this.productService.getProduct();
    products = productService.getProduct();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('token') == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }
  }

  fethcId() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? id = sharedPreferences.getString('userId');
    final response =
        await http.get(Uri.parse("http://localhost:8000/members/${id}"));
    final data = json.decode(response.body);
    nama = data['nama'];
    email = data['email'];
    print(nama);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProductForm()));
                }),
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                sharedPreferences.clear();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()),
                    (Route<dynamic> route) => false);
              },
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text("kentang"),
                accountEmail: Text(""),
              ),
              ListTile(
                title: Text('Logout'),
                trailing: Icon(Icons.exit_to_app),
                onTap: () {
                  sharedPreferences.clear();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage()),
                      (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: FutureBuilder<List<Product>>(
            future: products,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.hasData);
                return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    print(snapshot.data![index]);
                    return Card(
                      child: ItemProduct(product: snapshot.data![index]),
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }
}

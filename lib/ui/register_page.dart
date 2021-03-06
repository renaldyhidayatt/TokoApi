import 'package:coba_aja/models/register.dart';
import 'package:coba_aja/service/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _iLoading = false;

  final AuthService authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _namaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Nama",
                      hintText: "Masukkan nama anda",
                    ),
                    controller: _namaController,
                    validator: (value) {
                      if (value!.length < 3) {
                        return "Nama minimal 3 karakter";
                      }
                      if (value.isEmpty) {
                        return "Nama tidak boleh kosong";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Masukkan email anda",
                    ),
                    controller: _emailController,
                    validator: (value) {
                      if (value!.length < 3) {
                        return "Nama minimal 3 karakter";
                      }
                      if (value.isEmpty) {
                        return "Email tidak boleh kosong";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Masukkan password anda",
                    ),
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.length < 6) {
                        return "Nama minimal 6 karakter";
                      }
                      if (value.isEmpty) {
                        return "Password tidak boleh kosong";
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    child: Text("Register"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _iLoading = true;
                        });
                        authService.register(Register(
                            nama: _namaController.text,
                            email: _emailController.text,
                            password: _passwordController.text));

                        Future.delayed(Duration(seconds: 3), () {
                          setState(() {
                            _iLoading = false;
                          });
                          Navigator.pop(context);
                        });
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

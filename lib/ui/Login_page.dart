import 'package:coba_aja/models/login.dart';
import 'package:coba_aja/service/auth_service.dart';
import 'package:coba_aja/ui/home_page.dart';
import 'package:coba_aja/ui/register_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  bool _Loading = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: "Email"),
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your email";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Password"),
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                      child: Text("Login"),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _Loading = true;
                          });
                          _auth
                              .login(Login(
                                  email: _emailController.text,
                                  password: _passwordController.text))
                              .then((value) {
                            if (value != null) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            }
                          });
                        }
                      }),
                  Container(
                      child: Center(
                          child: InkWell(
                              child: Text(
                                "Register",
                                style: TextStyle(color: Colors.blue),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterPage()));
                              })))
                ])),
          ),
        ));
  }
}

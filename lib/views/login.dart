import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendas/controllers/auth_controller.dart';
import 'package:vendas/models/auth.dart';
import 'package:vendas/utils/snackbar.dart';
import 'package:vendas/views/home.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Form',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: LoginFormFields(),
        ),
      ),
    );
  }
}

class LoginFormFields extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginFormFields({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Auth>(context);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // if (_formKey.currentState!.validate()) {
              if (true) {
                AuthController()
                    .login('jeferson@gmail.com', '12234')
                    .catchError((e) {
                  SnackBarUtils.show(e.message.toString(), context);
                  throw e;
                }).then((value) {
                  provider.setAuth(value);

                  SnackBarUtils.show('Login efetuado com sucesso!', context);

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                });
              }
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}

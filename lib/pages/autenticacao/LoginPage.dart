// LoginPage.dart

import 'package:flutter/material.dart';
import '../../db/FirebaseDatabase.dart';
import '../../utils/ColorsCustom.dart';
import '../../utils/OtherCustom.dart';
import '../../routes/AppRoutes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsCustom.colorWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SB10,
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/login-image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SB30,
                Text(
                  'ENTRE COM SUA CONTA AQUI!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SB10,
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu e-mail';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Por favor, insira um e-mail válido';
                    }
                    return null;
                  },
                ),
                SB10,
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.password),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua senha';
                    }
                    if (value.length < 6) {
                      return 'A senha deve ter pelo menos 6 caracteres';
                    }
                    return null;
                  },
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.signUpPage);
                  },
                  child: Text('Não tem uma conta? Crie aqui'),
                  style: TextButton.styleFrom(
                    foregroundColor: ColorsCustom.colorPrimary,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.forgotPasswordPage);
                  },
                  child: Text('Esqueci minha senha'),
                  style: TextButton.styleFrom(
                    foregroundColor: ColorsCustom.colorPrimary,
                  ),
                ),
                SB10,
                ElevatedButton(
                  onPressed: () {
                    _loginPressed();
                  },
                  child: Text('Entrar'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: ColorsCustom.colorWhite,
                    backgroundColor: ColorsCustom.colorGreen,
                    minimumSize: Size(20, 50),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loginPressed() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;
      _firebaseDatabase.signInUser(
        context: context,
        email: email,
        password: password,
      );
    }
  }
}

// SignUpPage

import 'package:flutter/material.dart';
import '../../routes/AppRoutes.dart';
import '../../utils/ColorsCustom.dart';
import '../../utils/OtherCustom.dart';
import '../../db/FirebaseDatabase.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                      image: AssetImage('assets/images/sign-up-image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SB30,
                Text(
                  'CRIE SUA CONTA AQUI! :)',
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
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) { // Um REGEX para verificar se o email é válido
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
                    Navigator.pushNamed(context, AppRoutes.loginPage);
                  },
                  child: Text('Já tem uma conta? Entre aqui'),
                  style: TextButton.styleFrom(
                    foregroundColor: ColorsCustom.colorPrimary,
                  ),
                ),
                SB10,
                ElevatedButton(
                  onPressed: () {
                    _buttonPressed();
                  },
                  child: Text('Criar Conta'),
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

  /* Ao pressionar o botão, manda os dados de cadastro para createNewUser no firebaseDatabase */

  void _buttonPressed() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;
      _firebaseDatabase.createNewUser(
        context: context,
        email: email,
        password: password,
      );
    }
  }
}

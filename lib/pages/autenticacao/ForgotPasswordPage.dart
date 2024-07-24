import 'package:flutter/material.dart';
import '../../db/FirebaseDatabase.dart';
import '../../utils/ColorsCustom.dart';
import '../../utils/OtherCustom.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
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
                      image: AssetImage('assets/images/forgot-password-image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SB30,
                Text(
                  'REDEFINIR SENHA',
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
                ElevatedButton(
                  onPressed: () {
                    _resetPassword();
                  },
                  child: Text('Enviar e-mail de redefinição'),
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

  void _resetPassword() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      _firebaseDatabase.resetPassword(
        context: context,
        email: email,
      );
    }
  }
}

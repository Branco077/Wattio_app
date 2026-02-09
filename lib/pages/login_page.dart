import 'package:flutter/material.dart';
import '../data/fake_auth.dart';
import 'register_page.dart';
import 'home_page.dart';
import '../widgets/input_field.dart';
import '../models/user.dart';
import 'cooperativa/cooperativa_home_page.dart';

 class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

 class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  UserType selectedType = UserType.cliente;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF063A44),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 140),

            Image.asset(
              'assets/logo_wattio.png',
              height: 220,
            ),

            const SizedBox(height: 24),

            const Text(
              "Bem-vindo ao Wattio",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Energia inteligente, economia real",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 48),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    InputField(
                      label: "Email",
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Informe seu email";
                        }
                        final emailRegex =
                            RegExp(r'^[^@]+@[^@]+\.[^@]+');
                        if (!emailRegex.hasMatch(value)) {
                          return "Email inválido";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    InputField(
                      label: "Senha",
                      controller: passwordController,
                      obscure: true,
                    ),

                    const SizedBox(height: 64),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFEB00),
                        foregroundColor: const Color(0xFF063A44),
                        minimumSize: const Size(double.infinity, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                      if (!_formKey.currentState!.validate()) return;

                      if (passwordController.text != '123456') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Senha inválida"),
                          ),
                        );
                        return;
                      }

                      final success = FakeAuth.login(
                        emailController.text,
                        passwordController.text,
                        selectedType, 
                      );

                      if (!success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Usuário não encontrado"),
                          ),
                        );
                        return;
                      }

                      final user = FakeAuth.currentUser!;

                      if (user.type == UserType.cliente) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HomePage(),
                          ),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CooperativaHomePage(),
                          ),
                        );
                      }
                    },

                      child: const Text(
                        "Entrar",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegisterPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Criar conta",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

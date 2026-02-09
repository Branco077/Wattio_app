import 'package:flutter/material.dart';
import '../data/fake_auth.dart';
import 'login_page.dart';
import '../widgets/input_field.dart';
import '../models/user.dart';
import 'home_page.dart';
import 'cooperativa/cooperativa_home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  UserType selectedType = UserType.cliente;

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nomeController = TextEditingController();
    final sobrenomeController = TextEditingController();
    final enderecoController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: const Color(0xFF063A44),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 120),

            Image.asset(
              'assets/logo_wattio.png',
              height: 200,
            ),

            const SizedBox(height: 24),

            const Text(
              "Criar conta",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Faça parte do Wattio",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 40),

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
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return "Senha deve ter pelo menos 6 caracteres";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 24),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                selectedType = UserType.cliente;
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: selectedType == UserType.cliente
                                  ? Colors.white
                                  : Colors.transparent,
                              foregroundColor: selectedType == UserType.cliente
                                  ? const Color(0xFF063A44)
                                  : Colors.white,
                              side: const BorderSide(
                                color: Colors.white,
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: const Text("Sou cliente"),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: 
                          OutlinedButton(
                            onPressed: () {
                              setState(() {
                                selectedType = UserType.cooperativa;
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: selectedType == UserType.cooperativa
                                  ? Colors.white
                                  : Colors.transparent,
                              foregroundColor: selectedType == UserType.cooperativa
                                  ? const Color(0xFF063A44)
                                  : Colors.white,
                              side: const BorderSide(
                                color: Colors.white, // 👈 ESSENCIAL
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: const Text("Sou cooperativa"),
                          ),
                        ),
                      ],
                    ),

                    if (selectedType == UserType.cliente) ...[
                      const SizedBox(height: 16),

                      InputField(
                        label: "Nome",
                        controller: nomeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Informe seu nome";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      InputField(
                        label: "Sobrenome",
                        controller: sobrenomeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Informe seu sobrenome";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      InputField(
                        label: "Endereço",
                        controller: enderecoController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Informe seu endereço";
                          }
                          return null;
                        },
                      ),
                    ],

                    const SizedBox(height: 48),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFEB00),
                        foregroundColor: const Color(0xFF063A44),
                        minimumSize:
                            const Size(double.infinity, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;

                        FakeAuth.register(
                          emailController.text,
                          passwordController.text,
                          selectedType,
                        );

                        final user = FakeAuth.currentUser!;

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => user.type ==
                                    UserType.cliente
                                ? const HomePage()
                                : const CooperativaHomePage(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        "Cadastrar",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Já tenho conta",
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

import 'package:flutter/material.dart';
import '../models/cooperativa.dart';

class ResultadoPage extends StatelessWidget {
  final Cooperativa cooperativa;
  final double valorConta;

  const ResultadoPage({
    super.key,
    required this.cooperativa,
    required this.valorConta,
  });

  @override
  Widget build(BuildContext context) {
    final economia = cooperativa.economia(valorConta);
    final novoValor = cooperativa.novoValor(valorConta);

    return Scaffold(
      backgroundColor: const Color(0xFF063A44),
      appBar: AppBar(
        title: const Text("Resultado da simulação"),
        backgroundColor: const Color(0xFF063A44),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              cooperativa.nome,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Desconto aplicado: ${(cooperativa.desconto * 100).toInt()}%",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 32),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Sua conta atual",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      "R\$ ${valorConta.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Economia mensal",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      "- R\$ ${economia.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Divider(height: 32),

                    const Text(
                      "Novo valor da conta",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      "R\$ ${novoValor.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF063A44),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

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
                Navigator.pop(context);
              },
              child: const Text(
                "Escolher outra cooperativa",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

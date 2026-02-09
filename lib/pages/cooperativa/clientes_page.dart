import 'package:flutter/material.dart';
import '../../data/clientes_data.dart';
import '../../models/cliente.dart';

class ClientesPage extends StatelessWidget {
  const ClientesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final clientesVisiveis =
        clientesMock.where((c) => c.visivel).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF063A44),
      appBar: AppBar(
        title: const Text("Clientes disponíveis"),
        backgroundColor: const Color(0xFF063A44),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: clientesVisiveis.isEmpty
          ? const Center(
              child: Text(
                "Nenhum cliente disponível no momento",
                style: TextStyle(color: Colors.white70),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: clientesVisiveis.length,
              itemBuilder: (context, index) {
                final Cliente cliente = clientesVisiveis[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cliente.nome,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF063A44),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Conta mensal: R\$ ${cliente.valorConta.toStringAsFixed(2)}",
                        style: const TextStyle(color: Colors.black54),
                      ),
                      Text(
                        "Distância: ${cliente.distanciaKm} km",
                        style: const TextStyle(color: Colors.black54),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Economia estimada: R\$ ${cliente.economiaEstimada().toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),

                      const SizedBox(height: 16),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFEB00),
                            foregroundColor: const Color(0xFF063A44),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text("Proposta enviada ao cliente"),
                              ),
                            );
                          },
                          child: const Text(
                            "Enviar proposta",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      }

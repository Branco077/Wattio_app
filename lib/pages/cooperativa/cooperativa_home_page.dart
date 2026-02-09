import 'package:flutter/material.dart';
import '../../data/clientes_data.dart';
import 'clientes_page.dart';

class CooperativaHomePage extends StatelessWidget {
  const CooperativaHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final clientesVisiveis =
        clientesMock.where((c) => c.visivel).toList();

    final clientesProximos = clientesVisiveis
      .where((c) => c.distanciaKm <=4 )
      .toList()
      ..sort((a, b) => a.distanciaKm.compareTo(b.distanciaKm));

    return Scaffold(
      backgroundColor: const Color(0xFF063A44),
      appBar: AppBar(
        backgroundColor: const Color(0xFF063A44),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Visão geral",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Acompanhe clientes interessados na sua cooperativa",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _ResumoItem(
                      titulo: "Clientes",
                      valor: clientesVisiveis.length.toString(),
                      icon: Icons.people,
                    ),
                    _ResumoItem(
                      titulo: "Raio médio",
                      valor: "4 km",
                      icon: Icons.location_on,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton.icon(
              icon: const Icon(Icons.search),
              label: const Text("Ver clientes disponíveis"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFEB00),
                foregroundColor: const Color(0xFF063A44),
                elevation: 2,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ClientesPage(),
                  ),
                );
              },
            ),

            const SizedBox(height: 32),

            const Text(
              "Clientes próximos",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 12),

            ...clientesProximos.map(
              (cliente) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.person,
                    color: Color(0xFF063A44),
                  ),
                  title: Text(cliente.nome),
                  subtitle: Text(
                    "Conta média: R\$ ${cliente.valorConta.toStringAsFixed(0)} • ${cliente.distanciaKm} km",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResumoItem extends StatelessWidget {
  final String titulo;
  final String valor;
  final IconData icon;

  const _ResumoItem({
    required this.titulo,
    required this.valor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF063A44)),
        const SizedBox(height: 8),
        Text(
          valor,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF063A44),
          ),
        ),
        Text(
          titulo,
          style: const TextStyle(color: Colors.black54),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../data/cooperativas_data.dart';
import 'resultado_page.dart';

class OfertasPage extends StatefulWidget {
  final double valorConta;

  const OfertasPage({super.key, required this.valorConta});

  @override
  State<OfertasPage> createState() => _OfertasPageState();
}

class _OfertasPageState extends State<OfertasPage> {
  double ratingMinimo = 0;
  double distanciaMaxima = 50;

  @override
  Widget build(BuildContext context) {
    final cooperativasFiltradas = cooperativasMock.where((c) {
      return c.aceita(widget.valorConta) &&
          c.rating >= ratingMinimo &&
          c.distanciaKm <= distanciaMaxima;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF063A44),
      appBar: AppBar(
        backgroundColor: const Color(0xFF063A44),
        elevation: 0,
        foregroundColor: Colors.white,
        title: const Text("Ofertas disponíveis"),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Rating mínimo: ${ratingMinimo.toStringAsFixed(1)} ⭐",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF063A44),
                  ),
                ),
                Slider(
                  min: 0,
                  max: 5,
                  divisions: 5,
                  value: ratingMinimo,
                  activeColor: const Color(0xFF063A44),
                  onChanged: (value) {
                    setState(() {
                      ratingMinimo = value;
                    });
                  },
                ),

                const SizedBox(height: 8),

                const Text(
                  "Distância máxima",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF063A44),
                  ),
                ),
                const SizedBox(height: 4),
                DropdownButtonFormField<double>(
                  value: distanciaMaxima,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: 10, child: Text("Até 10 km")),
                    DropdownMenuItem(value: 20, child: Text("Até 20 km")),
                    DropdownMenuItem(value: 50, child: Text("Até 50 km")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      distanciaMaxima = value!;
                    });
                  },
                ),
              ],
            ),
          ),

          Expanded(
            child: cooperativasFiltradas.isEmpty
                ? const Center(
                    child: Text(
                      "Nenhuma cooperativa encontrada",
                      style: TextStyle(color: Colors.white70),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: cooperativasFiltradas.length,
                    itemBuilder: (context, index) {
                      final c = cooperativasFiltradas[index];

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
                              c.nome,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF063A44),
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              "⭐ ${c.rating} • 📍 ${c.distanciaKm} km",
                              style: const TextStyle(color: Colors.black54),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              "Economia estimada: R\$ ${c.economia(widget.valorConta).toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 16),

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFEB00),
                                  foregroundColor:
                                      const Color(0xFF063A44),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ResultadoPage(
                                        cooperativa: c,
                                        valorConta: widget.valorConta,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text("Selecionar"),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      }

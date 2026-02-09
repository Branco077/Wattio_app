class Cliente {
  final String nome;
  final double valorConta;
  final double distanciaKm;
  final bool visivel;

  Cliente({
    required this.nome,
    required this.valorConta,
    required this.distanciaKm,
    required this.visivel,
  });

  double economiaEstimada() {
    return valorConta * 0.2;
  }
}

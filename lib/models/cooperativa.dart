class Cooperativa {
  final String nome;
  final double valorMinimo;
  final double valorMaximo;
  final double desconto;
  final double rating;
  final double distanciaKm;

  Cooperativa({
    required this.nome,
    required this.valorMinimo,
    required this.valorMaximo,
    required this.desconto,
    required this.rating,
    required this.distanciaKm,
  });

  bool aceita(double valorConta) {
    return valorConta >= valorMinimo &&
        valorConta <= valorMaximo;
  }

  double economia(double valorConta) {
    return valorConta * desconto;
  }

  double novoValor(double valorConta) {
    return valorConta - economia(valorConta);
  }
}

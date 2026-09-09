class Pergunta {
  final String texto;
  final List<String> respostas;

  const Pergunta(this.texto, this.respostas);

  List<String> embaralha() {
    final respostasEmbaralhadas = List<String>.from(respostas);
    respostasEmbaralhadas.shuffle();

    return respostasEmbaralhadas;
  }
}

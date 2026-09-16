class FraseModelo {
  final String texto;
  final String autor;
  final String imagem;
  bool like = false;
  String comentario = '';

  FraseModelo({required this.texto, required this.autor, required this.imagem});

  bool get liked => like;

  void mudaLike() {
    like = !like;
  }
}

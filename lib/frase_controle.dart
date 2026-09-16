import 'frase_modelo.dart';

class FraseControle {
  final List<FraseModelo> frases = [
    FraseModelo(
        texto: 'Deodoro da Fonseca',
        autor: 'Fonte: Wikipédia',
        imagem: 'assets/imagens/deodoro.jpg'),
    FraseModelo(
        texto: 'Floriano Peixoto',
        autor: 'Fonte: Wikipédia',
        imagem: 'assets/imagens/floriano.jpg'),
    FraseModelo(
        texto: 'Prudente de Morais',
        autor: 'Fonte: Wikipédia',
        imagem: 'assets/imagens/prudente.jpg'),
    FraseModelo(
        texto: 'Campos Sales',
        autor: 'Fonte: Wikipédia',
        imagem: 'assets/imagens/campos.jpg'),
    FraseModelo(
        texto: 'Rodrigues Alves',
        autor: 'Fonte: Wikipédia',
        imagem: 'assets/imagens/rodrigues.jpg'),
  ];

  int atual = 0;
  FraseModelo get fraseAtual => frases[atual];

  void proximaFrase() {
    if (atual < frases.length - 1) {
      atual++;
    } else {
      atual = 0;
    }
  }
}

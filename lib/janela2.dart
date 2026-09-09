import 'package:flutter/material.dart';

import 'pergunta.dart';
import 'questoes.dart';

class Janela2 extends StatefulWidget {
  const Janela2({
    super.key,
  });

  @override
  State<Janela2> createState() => _Janela2State();
}

class _Janela2State extends State<Janela2> {
  int indice = 0;

  @override
  Widget build(BuildContext context) {
    Pergunta perguntaAtual = questoes[indice];

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Opacity(
              opacity: 0.8,
              child: Image.asset(
                'assets/imagens/cat.png',
              ),
            ),
          ),
          Text(perguntaAtual.texto),
          const SizedBox(
            height: 10,
          ),
          ...perguntaAtual.embaralha().map((resposta) {
            return BotaoResposta(
              chamar: () {
                setState(() {
                  if (indice < questoes.length - 1) {
                    indice++;
                  }
                });
                print('Apertado: $resposta');
              },
              texto: resposta,
            );
          }),
        ],
      ),
    );
  }
}

class BotaoResposta extends StatelessWidget {
  const BotaoResposta({
    super.key,
    required this.texto,
    required this.chamar,
  });

  final String texto;
  final Function() chamar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: chamar,
        child: Text(texto),
      ),
    );
  }
}

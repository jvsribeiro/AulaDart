import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const Janela());
}

class Janela extends StatelessWidget {
  const Janela({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Principal()),
    );
  }
}

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  final TextEditingController controlaTexto = TextEditingController();
  final Random sorteio = Random();
  int primeiro = 1;
  int segundo = 1;
  bool? correta;

  @override
  void initState() {
    super.initState();
    controlaTexto.addListener(imprime);
    primeiro = sorteio.nextInt(10) + 1;
    segundo = sorteio.nextInt(10) + 1;
  }

  void imprime() {
    final texto = controlaTexto.text.trim();
    setState(() {
      correta =
          texto.isEmpty ? null : int.tryParse(texto) == primeiro * segundo;
    });
  }

  void proximaOperacao() {
    // Sorteia uma das outras 99 operações da tabuada de 1 a 10.
    final atual = (primeiro - 1) * 10 + segundo - 1;
    var proxima = sorteio.nextInt(99);
    if (proxima >= atual) proxima++;
    setState(() {
      primeiro = proxima ~/ 10 + 1;
      segundo = proxima % 10 + 1;
      correta = null;
    });
    controlaTexto.clear();
  }

  @override
  void dispose() {
    controlaTexto.removeListener(imprime);
    controlaTexto.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Treine a tabuada', style: TextStyle(fontSize: 28)),
                const SizedBox(height: 24),
                Text('$primeiro × $segundo = ?',
                    key: const Key('operacao'),
                    style: const TextStyle(fontSize: 36)),
                const SizedBox(height: 24),
                TextField(
                  controller: controlaTexto,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Sua resposta',
                    hintText: 'Digite o resultado',
                    suffixIcon: correta == null
                        ? null
                        : Icon(
                            correta! ? Icons.check_circle : Icons.cancel,
                            color: correta! ? Colors.green : Colors.red,
                          ),
                  ),
                ),
                const SizedBox(height: 12),
                Semantics(
                  liveRegion: true,
                  child: Text(
                    correta == null
                        ? 'Digite uma resposta para conferir.'
                        : correta!
                            ? 'Correto!'
                            : 'Incorreto. Tente novamente.',
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: proximaOperacao,
                  child: const Text('Próxima operação'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

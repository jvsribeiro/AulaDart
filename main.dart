import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Galeria(),
    );
  }
}

// IMAGENS
const List<String> imagens = [
  'https://upload.wikimedia.org/wikipedia/commons/b/be/08.08.2026_-_FOTOS_OFICIAIS_-_55450293419.jpg',
  'https://upload.wikimedia.org/wikipedia/commons/d/da/2026_RENAN_SANTOS_CANDIDATO_PRESIDENTE_TSE_%28280002540694%29.jpg',
  'https://upload.wikimedia.org/wikipedia/commons/3/30/2026_FLAVIO_BOLSONARO_CANDIDATO_PRESIDENTE_TSE_%28280002551544%29.jpg',
  'https://upload.wikimedia.org/wikipedia/commons/3/37/2026_RONALDO_CAIADO_CANDIDATO_PRESIDENTE_TSE_%28280002551932%29.jpg',
];

// =====================================================
// GALERIA
// =====================================================

class Galeria extends StatefulWidget {
  const Galeria({super.key});

  @override
  State<Galeria> createState() => _GaleriaState();
}

class _GaleriaState extends State<Galeria> {
  List<String> aprovadas = [];

  Future<void> avaliar(String imagem) async {
    final resultado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => Avaliar(
          imagem: imagem,
        ),
      ),
    );

    if (resultado == true) {
      if (!aprovadas.contains(imagem)) {
        setState(() {
          aprovadas.add(imagem);
        });
      }
    }

    if (resultado == false) {
      setState(() {
        aprovadas.remove(imagem);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galeria'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Aprovadas(
                    imagens: aprovadas,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: imagens.map((imagem) {
            return InkWell(
              onTap: () {
                avaliar(imagem);
              },
              child: Image.network(
                imagem,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// =====================================================
// TELA DE AVALIAÇÃO
// =====================================================

class Avaliar extends StatelessWidget {
  final String imagem;

  const Avaliar({
    super.key,
    required this.imagem,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avaliar imagem'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.network(
                  imagem,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Text('APROVAR'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text('REPROVAR'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// IMAGENS APROVADAS
// =====================================================

class Aprovadas extends StatelessWidget {
  final List<String> imagens;

  const Aprovadas({
    super.key,
    required this.imagens,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imagens Aprovadas'),
      ),
      body: imagens.isEmpty
          ? const Center(
              child: Text(
                'Nenhuma imagem aprovada',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: imagens.map((imagem) {
                  return Image.network(
                    imagem,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  );
                }).toList(),
              ),
            ),
    );
  }
}

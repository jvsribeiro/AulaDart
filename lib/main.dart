import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class Endereco {
  final String rua;
  final String bairro;
  final String cidade;
  final String estado;

  const Endereco({
    required this.rua,
    required this.bairro,
    required this.cidade,
    required this.estado,
  });

  factory Endereco.fromJson(Map<String, dynamic> json) {
    return Endereco(
      rua: json['logradouro'] ?? '',
      bairro: json['bairro'] ?? '',
      cidade: json['localidade'] ?? '',
      estado: json['estado'] ?? json['uf'] ?? '',
    );
  }
}

Future<Endereco> buscarCep(String cep) async {
  cep = cep.replaceAll('-', '');

  final resposta = await http.get(
    Uri.parse('https://viacep.com.br/ws/$cep/json/'),
  );

  if (resposta.statusCode == 200) {
    final dados = jsonDecode(resposta.body) as Map<String, dynamic>;

    if (dados['erro'] == true) {
      throw Exception('CEP não encontrado');
    }

    return Endereco.fromJson(dados);
  } else {
    throw Exception('Erro ao buscar CEP');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController cepController = TextEditingController();

  Future<Endereco>? enderecoFuturo;

  void consultarCep() {
    setState(() {
      enderecoFuturo = buscarCep(
        cepController.text,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Consulta CEP'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: cepController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Digite o CEP',
                  hintText: 'Ex: 14700-000',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: consultarCep,
                child: const Text('Buscar'),
              ),
              const SizedBox(height: 30),
              if (enderecoFuturo != null)
                FutureBuilder<Endereco>(
                  future: enderecoFuturo,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final endereco = snapshot.data!;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rua: ${endereco.rua}',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Bairro: ${endereco.bairro}',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Cidade: ${endereco.cidade}',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Estado: ${endereco.estado}',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      );
                    }

                    if (snapshot.hasError) {
                      return Text(
                        '${snapshot.error}',
                      );
                    }

                    return const CircularProgressIndicator();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

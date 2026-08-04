void main() {
  String nome = 'Camiseta ADS';
  int quantidade = 3;
  double preco = 49.90;
  bool disponivel = true;
  const double imposto = 5.0;

  double valorTotal = (quantidade * preco) * (1 + imposto / 100);

  print('Produto: $nome');
  print('Disponível em estoque: $disponivel');
  print('Quantidade: $quantidade');
  print('Preço unitário: $preco');
  print('Valor total: R\$ ${valorTotal.toStringAsFixed(2)}');
}

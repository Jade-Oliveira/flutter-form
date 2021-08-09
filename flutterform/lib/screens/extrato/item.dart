import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  late String _valor;
  late String _conta;
  late String _tipo;
  late Map<String, Color> _cores = {
    'debito': Colors.red,
    'credito': Colors.green,
  };

  Item(this._valor, this._conta, this._tipo);

  Item.transferencia(this._valor, this._conta) {
    this._tipo = 'debito';
  }
  Item.deposito(this._valor) {
    this._tipo = 'credito';
    this._conta = '';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
          leading: Icon(
            Icons.monetization_on,
            color: _cores[_tipo],
          ),
          title: Text(_valor),
          subtitle: Text(_conta),
        ));
  }
}

import 'package:flutter/material.dart';

class ModalCustom extends StatelessWidget {

  ModalCustom(this.nome);

  final String nome;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Deseja remover esse resultado?'),
      content: Text('Nome: $nome'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Não');
          },
          child: Text('Não'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Sim');
          },
          child: Text('Sim'),
        ),
      ],
    );
  }
}

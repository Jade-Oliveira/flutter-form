import 'package:flutter/material.dart';

exibirAlerta({context, titulo, content}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(content),
          actions: [
            TextButton(
                onPressed: () {
                  //fechar janela de diálogo
                  Navigator.pop(context);
                },
                child: Text('Fechar'))
          ],
        );
      });
}

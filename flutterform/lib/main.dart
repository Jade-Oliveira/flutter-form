import 'package:flutterform/models/saldo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/cliente.dart';
import 'models/transferencias.dart';
import 'screens/autenticacao/login.dart';



void main() => runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider(
      create: (context) => Saldo(0),
    ),
    ChangeNotifierProvider(
      create: (context) => Transferencias(),
    ),
    ChangeNotifierProvider(
        create: (context) => Cliente(),
    ),
  ],
  child: BytebankApp(),
));

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Color.fromRGBO(71, 161, 56, 1),
        buttonTheme: ButtonThemeData(
          buttonColor: Color.fromRGBO(71, 161, 56, 1),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: Login(),
    );
  }
}

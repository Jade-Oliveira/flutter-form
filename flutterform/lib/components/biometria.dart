import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterform/models/cliente.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class Biometria extends StatelessWidget {

  final LocalAuthentication _autenticacaoLocal = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    //precisamos acessar a função _biometriaDisponivel, mas não podemos colocar na árvore de widgets um widget assíncrono
    //por isso retornamos um futureBuilder que é um widget que espera um elemento futuro

    return FutureBuilder(
        future: _biometriaDisponivel(),
        builder: (context, snapshot) {
          //se a função que tá vindo como futuro retornar os dados como true, executa esse if
          if(snapshot.data == true) {
            return Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Column(
                  children: [
                    Text(
                      'Detectamos que você tem sensor biométrico no seu smartphone, deseja cadatrar o acesso biométrico?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),

                    SizedBox(height: 20),

                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            primary: Theme.of(context).accentColor,
                            backgroundColor: Colors.green),
                        onPressed: () async {
                          await _autenticarCliente(context);

                        },
                        child: Text('Habilitar impressão digital',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                        )
                    )
                  ],
                ),
            );
          }
          return Container();
        }
    );
  }

  Future<bool?> _biometriaDisponivel() async {
    try {
      return await _autenticacaoLocal.canCheckBiometrics;
    } on PlatformException catch (erro) {
      print(erro);
    }
  }

  Future<void> _autenticarCliente(context) async {
    bool autenticado = false;
    autenticado = await _autenticacaoLocal.authenticateWithBiometrics(
      localizedReason: 'Por favor autentique-se via biometria para acessar o Bytebank',
      useErrorDialogs: true,
    );
    Provider
        .of<Cliente>(context)
        .biometria = autenticado;
  }
}

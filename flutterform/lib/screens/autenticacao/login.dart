import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterform/components/mensagem.dart';
import 'package:flutterform/screens/autenticacao/registrar.dart';
import 'package:flutterform/screens/dashboard/dashboard.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';

class Login extends StatelessWidget {
  TextEditingController _cpfController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child:
                Image.asset('assets/images/bytebank_logo.png', width: 200),
              ),
              //formulário
              SizedBox(height: 30),

              Align(
                alignment: Alignment.center,
                //retângulo formulário
                child: Container(
                  width: 300,
                  height: 455,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),

                  //vamos especificar o campo texto que vai formar o login
                  child: Padding(
                    //cria uma margem interna no container
                      padding: const EdgeInsets.all(20),
                      //coloca como child do padding uma coluna porque precisamos colocar várias coisas dentro do container
                      child: _construirFormulario(context)
                  ),
                ),
              ),
              //margem interna - título
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      backgroundColor: Theme
          .of(context)
          .accentColor,
    );
  }

  Widget _construirFormulario(context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          Text(
            'Faça seu login',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          //para dar um espaço entre os campos
          SizedBox(height: 15),
          //textfiedl exige uma decoration para permitir que a coloquemos um label
          TextFormField(
            decoration: InputDecoration(
              labelText: 'CPF',
            ),
            //limita o número de caracteres aceitos
            maxLength: 14,
            inputFormatters: [
              //formatar o input de texto apenas com números e o cpfInput coloca o máscara
              FilteringTextInputFormatter.digitsOnly,
              CpfInputFormatter(),
            ],
            //value é o valor que o usuário digita no campo
            validator: (value) => Validator.cpf(value) ? 'CPF inválido' : null,
            keyboardType: TextInputType.number,
            //controller nos dá autonomia de pegar o que foi digitado pelo usuário no campo
            controller: _cpfController,
          ),

          SizedBox(
            height: 15,
          ),

          TextFormField(
            decoration: InputDecoration(
              labelText: 'Senha',
            ),
            maxLength: 15,
            validator: (value) {
              if(value!.length == 0) {
                return 'Informe a senha!';
              }
              return null;
            },
            keyboardType: TextInputType.text,
            controller: _senhaController,
          ),

          SizedBox(
            height: 30,
          ),

          //Botão
          SizedBox(
            //largura máxima disponível para esse widget
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: Theme
                    .of(context)
                    .accentColor,
                side: BorderSide(
                    color: Theme
                        .of(context)
                        .accentColor,
                    width: 2),
                backgroundColor: Theme
                    .of(context)
                    .accentColor,
              ),
              child: Text('Entrar', style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold)
              ),
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  if(_cpfController.text == '841.491.190-07' && _senhaController.text == 'abc841123') {
                    //pushRemoveUntil remove o histórico que estamos utilizando
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          //builder constrói efetivamente a rota, o retorno é o widget que vamos abrir como tela
                          builder: (context) => Dashboard(),
                        ),
                        //espera ainda uma função anônima que recebe um route, basicamente é uma configuração do que especificamos aqui
                        //pode ser uma rota pré definida no main, ex: /produtos, ou um widget, que é nosso caso
                        //isso basicamente tira o botão de voltar no canto esquerdo
                            (route) => false);
                  } else {
                    exibirAlerta(
                        context: context,
                        titulo: 'ATENÇÃO!',
                        content: 'CPF ou senha incorretos!'
                    );
                  }
                }
              },
            ),
          ),
          SizedBox(height: 15),

          Text(
            'Esqueci minha senha >',
            style: TextStyle(
              color: Theme
                  .of(context)
                  .accentColor,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 25),

          OutlinedButton(
            style: OutlinedButton.styleFrom(
              primary: Theme
                  .of(context)
                  .accentColor,
              side: BorderSide(
                  color: Theme
                      .of(context)
                      .accentColor,
                  width: 2),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Registrar()
                  )
              );
            },
            child: Text('Criar uma conta',
                style: TextStyle(
                    color: Theme
                        .of(context)
                        .accentColor,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

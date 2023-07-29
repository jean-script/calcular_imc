import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _textInfo = 'Informe seus dados';

  void _resetFields() {
    pesoController.clear();
    alturaController.clear();
    setState(() {
      _textInfo = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void calculaIMC() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);
      if (imc <= 18.5) {
        _textInfo = 'Seu IMC $imc, Esta Abaixo do Peso';
      } else if (imc >= 18.6 && imc <= 24.9) {
        _textInfo =
            'Seu IMC ${imc.toStringAsPrecision(2)}, Peso ideal(Parabéns)';
      } else if (imc >= 25.0 && imc <= 29.9) {
        _textInfo =
            'Seu IMC ${imc.toStringAsPrecision(2)}, Levemnete acima do peso';
      } else if (imc >= 30.0 && imc <= 34.9) {
        _textInfo = 'Seu IMC ${imc.toStringAsPrecision(2)}, Obesidade grau I';
      } else if (imc >= 35.0 && imc <= 39.9) {
        _textInfo = 'Seu IMC ${imc.toStringAsPrecision(2)}, Obesidade grau II';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: _resetFields,
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body:
          // faz com que a tela tenha um scroll caso o conteudo não caiba
          SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.green,
              ),
              TextFormField(
                controller: pesoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (KG)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Insira seu peso';
                  }
                },
              ),
              TextFormField(
                controller: alturaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Insira sua altura';
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        calculaIMC();
                      }
                    },
                    child: Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
              ),
              Text(
                _textInfo,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
              )
            ],
          ),
        ),
      ),
    );
  }
}

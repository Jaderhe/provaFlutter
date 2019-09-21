import 'dart:math';

import 'package:flutter/material.dart';
import 'package:prova/alert.dart';

class Imc extends StatefulWidget {
  
  
  @override
  _ImcState createState() => new _ImcState();

}



class _ImcState extends State<Imc> {

  @override
  void initState(){
    super.initState();
  }

  GlobalKey<FormState> _key = new GlobalKey();
  bool validate = false;
  final peso = new TextEditingController();
  final altura = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cálculo IMC"),
      ),
      body: new SingleChildScrollView(
        child: new Container(
          margin: new EdgeInsets.all(25),
          child: new Form(
            key: _key,
            autovalidate: validate,
            child: buildScreen(context),            
          ),
        ),
      ),
    );  
  }

  Widget buildScreen(BuildContext context){
    return new Column(
      children: <Widget>[
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Peso'),
          maxLength: 10,
          keyboardType: TextInputType.number,
          validator: validateField,
          controller: peso,
        ), 
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Altura em M'),
          keyboardType: TextInputType.number,
          maxLength: 10,
          validator: validateField,
          controller: altura,
        ), 
        new RaisedButton(
          onPressed: () {calcular(context); },
          child: Text('Calcular'),
        ),
        new RaisedButton(
          onPressed: () {Navigator.pop(context); },
          child: Text('Voltar'),
        ) 
      ],
    );
  }

  String validateField(String value){
    if (value.length == 0){
      return "Informe campo!";
    }
    if ( double.parse(value) < 0 ){
      return "Não pode ser negativo";
    }
    return null;
  }

  void calcular(BuildContext context) {
    if (_key.currentState.validate()){
      double result = double.parse(peso.text) / 
      (pow(double.parse(altura.text), 2));
        
        //double.parse(altura.text) * double.parse(altura.text));

    double resultado = double.parse(result.toStringAsPrecision(2));


      new Alert().showAlertDialog(context, "Seu IMC é: "+resultado.toString() +
       " classificação: " + classImc(resultado));
       resetCampos();
    }
  }

  String classImc(double imc){
    if (imc < 16) {
      return "Magreza grau III";
    } else if (imc >= 16 && imc <= 16.9){
      return "Magreza grau II";
    } else if (imc >= 17 && imc <= 18.4) {
      return "Magreza grau I";
    } else if (imc >= 18.5 && imc <= 24.9) {
      return "Adequado";
    } else if (imc >= 25 && imc <= 29.9) {
      return "Pré-Obeso";
    } else if (imc >= 30 && imc <= 34.9) {
      return "Obesidade grau I";
    } else if (imc >= 35 && imc <= 39.9) {
      return "Obesidade grau II";
    } else if (imc >= 40) {
      return "Obesidade grau III";
    } else {
      return "Inválido";
    }
    return null;
  }

  void resetCampos(){
    peso.clear();
    altura.clear();
  }

}

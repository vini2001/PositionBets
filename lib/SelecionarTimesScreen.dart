import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Aposta.dart';
import 'BettingScreen.dart';
import 'MoneyFormatter.dart';
import 'MyAlert.dart';

class SelecionarTimesScream extends StatefulWidget {

  @override
  _SelecionarTimesScreenState createState() => _SelecionarTimesScreenState();
}

class _SelecionarTimesScreenState extends State<SelecionarTimesScream> {


  final TextEditingController _time1Controller = TextEditingController();
  final TextEditingController _time2Controller = TextEditingController();


  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Definir times"),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.all(20),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              TextFormField(
                controller: _time1Controller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: "Time 1",
                    labelText: "Time 1"
                ),
              ),

              TextFormField(
                controller: _time2Controller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: "Time 2",
                    labelText: "Time 2"
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _continuar,
        tooltip: 'Continuar',
        child: Icon(Icons.send),
      ),
    );
  }

  void _continuar() {
    String time1 = _time1Controller.text;
    String time2 = _time2Controller.text;
    if(time1.length == 0 || time2.length == 0){
      MyAlert.alert(context, "Erro", "Digite os nomes dos times");
      return;
    }
    BettingScreen.time1 = time1;
    BettingScreen.time2 = time2;
    List<String> times = [time1, time2];
    Navigator.of(context).pop(times);
  }

}

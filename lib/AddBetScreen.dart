import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Aposta.dart';
import 'BettingScreen.dart';
import 'Formatacao.dart';
import 'MoneyFormatter.dart';
import 'MyAlert.dart';

class AddBetScreen extends StatefulWidget {
  AddBetScreen();

  @override
  _AddBetScreenState createState() => _AddBetScreenState();
}

class _AddBetScreenState extends State<AddBetScreen> {


  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _oddController = TextEditingController();
  final TextEditingController _time1ScoreController = TextEditingController();
  final TextEditingController _time2ScoreController = TextEditingController();

  List<double> handicaps = new List();

  List<DropdownMenuItem<double>> _dropDownHandicaps;
  double _currentHandicap;

  bool _time1Selecionado = false;
  bool _time2Selecionado = false;

  bool _handcapAsiatico = true;
  bool _under = false;
  bool _over = false;

  String _currentSpinner = "Handcap Asiático";

  @override
  void initState() {
    for(double i = -3.0; i <= 3.0; i+= 0.25){
      handicaps.add(i);
    }

    _dropDownHandicaps = getDropDownMenuHandicaps();
    _currentHandicap = 0.0;
  }

  List<DropdownMenuItem<double>> getDropDownMenuHandicaps() {
    List<DropdownMenuItem<double>> items = new List();
    for (double handicap in handicaps) {

      items.add(new DropdownMenuItem(
          value: handicap,
          child: new Text(handicap.toString())
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar aposta"),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        new Checkbox(value: _handcapAsiatico, onChanged: _handcapCbChanged),
                        GestureDetector(
                          child: Text("Handcap Asiático"),
                          onTap: () => _handcapCbChanged(!_handcapAsiatico),
                        )
                      ],
                    ),

                    Row(
                      children: <Widget>[
                        new Checkbox(value: _over, onChanged: _overCbChanged),
                        GestureDetector(
                          child: Text("Over"),
                          onTap: () => _overCbChanged(!_over),
                        )
                      ],
                    ),

                    Row(
                      children: <Widget>[
                        new Checkbox(value: _under, onChanged: _underCbChanged),
                        GestureDetector(
                          child: Text("Under"),
                          onTap: () => _underCbChanged(!_under),
                        )
                      ],
                    )
                  ],
                ),
                margin: EdgeInsets.only(bottom: 15),
              ),

              _handcapAsiatico ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Vou apostar no "),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          new Checkbox(value: _time1Selecionado, onChanged: _time1Changed),
                          GestureDetector(
                            child: Text(BettingScreen.time1),
                            onTap: () => _time1Changed(!_time1Selecionado),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          new Checkbox(value: _time2Selecionado, onChanged: _time2Changed),
                          GestureDetector(
                            child: Text(BettingScreen.time2),
                            onTap: () => _time2Changed(!_time2Selecionado),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ) : Container(),

              Container(
                child: TextFormField(
                  controller: _valorController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Valor da Aposta",
                      labelText: "Valor da Aposta"
                  ),
                  inputFormatters: [MoneyFormatter()],
                ),
              ),

              TextFormField(
                controller: _oddController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Odd",
                    labelText: "Odd"
                ),
              ),

              Container(
                child: Text(_currentSpinner),
                margin: EdgeInsets.only(top: 20),
              ),

              Container(
                child: DropdownButton(
                  value: _currentHandicap,
                  items: _dropDownHandicaps,
                  onChanged: changedDropDownHandicaps,
                ),
                width: double.infinity,
              ),

              _handcapAsiatico ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _time1ScoreController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Quantos gols o ${BettingScreen.time1} já fez?",
                        hintText: "Gols ${BettingScreen.time1}"
                    ),
                  ),
                  TextFormField(
                    controller: _time2ScoreController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Quantos gols o time ${BettingScreen.time2} já fez?",
                        hintText: "Gols ${BettingScreen.time2}"
                    ),
                  ),
                ],
              ) : Container()

            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _addBet,
        tooltip: 'Adicionar',
        child: Icon(Icons.send),
      ),
    );
  }

  void changedDropDownHandicaps(double selectedHandicap) {
    setState(() {
      _currentHandicap = selectedHandicap;
    });
  }

  void _addBet() {

    if(_valorController.text.length < 1 ||  double.parse(_valorController.text.replaceAll(",", ".")) == 0){
      MyAlert.alert(context, "Erro", "Valor de aposta inválido");
      return;
    }

    if(_oddController.text.length < 1 ||  double.parse(_oddController.text.replaceAll(",", ".")) < 1){
      MyAlert.alert(context, "Erro", "Odd inválida");
      return;
    }

    if(!_time1Selecionado && !_time2Selecionado && _handcapAsiatico){
      MyAlert.alert(context, "Erro", "Escolha um time");
      return;
    }

    if(!_handcapAsiatico && !_over && !_under){
      MyAlert.alert(context, "Erro", "Sua aposta é normal, over ou under? Selecione algum checkbox!");
      return;
    }

    if(_time1ScoreController.text.length == 0) _time1ScoreController.text = "0";
    if(_time2ScoreController.text.length == 0) _time2ScoreController.text = "0";


    Aposta aposta = Aposta();
    aposta.valor = double.parse(_valorController.text.replaceAll(",", "."));
    aposta.odd = double.parse(_oddController.text.replaceAll(",", "."));
    aposta.handicapTime1 = _currentHandicap;
    aposta.time1scoreInicial = _handcapAsiatico ? double.parse(_time1ScoreController.text.replaceAll(",", ".")) : 0;
    aposta.time2scoreInicial = _handcapAsiatico ? double.parse(_time2ScoreController.text.replaceAll(",", ".")) : 0;
    aposta.apostaTime1 = _time1Selecionado;
    aposta.over = _over;
    aposta.under = _under;
    Navigator.of(context).pop(aposta);
  }

  void _time1Changed(bool value) {
    setState(() {
      _time1Selecionado = value;
      _time2Selecionado = !value;
    });
  }

  void _time2Changed(bool value) {
    setState(() {
      _time2Selecionado = value;
      _time1Selecionado = !value;
    });
  }

  void _handcapCbChanged(bool value) {
    setState(() {
      _handcapAsiatico = value;
      if(_handcapAsiatico){
        _over = false;
        _under = false;

        handicaps.clear();
        for(double i = -3.0; i <= 3.0; i+= 0.25){
          handicaps.add(i);
        }

        _dropDownHandicaps = getDropDownMenuHandicaps();
        _currentHandicap = 0.0;

        _currentSpinner = "Handcap Asiático";

      }
    });
  }

  _overCbChanged(bool value) {
    setState(() {
      _over = value;
      if(_over){
        _handcapAsiatico = false;
        _under = false;

        handicaps.clear();
        for(double i = 0; i <= 5.0; i+= 0.25){
          handicaps.add(i);
        }

        _dropDownHandicaps = getDropDownMenuHandicaps();
        _currentHandicap = 0.0;

        _currentSpinner = "Over";

      }
    });
  }

  _underCbChanged(bool value) {
    setState(() {
      _under = value;
      if(_under){
        _handcapAsiatico = false;
        _over = false;

        handicaps.clear();
        for(double i = 0; i <= 5.0; i+= 0.25){
          handicaps.add(i);
        }

        _dropDownHandicaps = getDropDownMenuHandicaps();
        _currentHandicap = 0.0;

        _currentSpinner = "Under";

      }
    });
  }
}

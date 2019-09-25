import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AddBetScreen.dart';
import 'Aposta.dart';
import 'Formatacao.dart';
import 'MyAlert.dart';
import 'SelecionarTimesScreen.dart';

class BettingScreen extends StatefulWidget {
  BettingScreen();

  static String time1, time2;

  @override
  _BettingScreenState createState() => _BettingScreenState();
}

class _BettingScreenState extends State<BettingScreen> {


  List<Aposta> apostas = new List();
  int minScoreTime1 = 0, minScoreTime2 = 0;

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text("Position Bets"),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 50,
                  child: ListView.builder(
                      itemCount: 11,
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        return Container(
                          color: Colors.blueGrey,
                          height: 30,
                          width: 50,
                          child: Center(
                            child: Text(index == 0 ? "T1/T2" : (index-1).toString(), style: TextStyle(color: Colors.white)),
                          ),
                        );
                      }),
                ),
                Expanded(
                  child: Container(
                    height: 330,
                    child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, indexColuna) {
                          return Container(
                            //Container Horizontal
                            width: 80,
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 11,
                                shrinkWrap: true,
                                itemBuilder: (context, indexLinha) {
                                  return indexLinha > 0 ? Container(
                                    //Container Vertical
                                    height: 30,
                                    padding: EdgeInsets.symmetric(horizontal: 3),
                                    child: Center(
                                      child: Text((indexLinha-1 < minScoreTime1 || indexColuna < minScoreTime2) ? "IMPOS." : Formatacao.getStringMoney(getSomaValoresApostas((indexLinha-1).toDouble(), indexColuna.toDouble())), style: TextStyle(color: Colors.white)),
                                    ),
                                    color: (indexLinha-1 < minScoreTime1 || indexColuna < minScoreTime2) ? Theme.of(context).primaryColor : getColor(getSomaValoresApostas((indexLinha-1).toDouble(), indexColuna.toDouble())),
                                  ) : Container(
                                    //Container Vertical
                                    height: 30,
                                    child: Center(
                                      child: Text((indexColuna).toString(),
                                          style: TextStyle(color: Colors.white)),
                                    ),
                                    color: Colors.blueGrey,
                                  );
                                }),
                          );
                        }),
                  ),
                )
              ],
            ),
          ),
          Flexible(
            child: Container(
              child: ListView.builder(
                  itemCount: apostas.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    return Container(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Aposta ${(index+1).toString()}", style: TextStyle(color: Colors.white)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(Formatacao.getStringMoney(apostas[index].valor), style: TextStyle(color: Colors.white)),
                                  Text("${apostas[index].getModalidade()}: " + apostas[index].handicapTime1.toString(), style: TextStyle(color: Colors.white)),
                                  (!apostas[index].over && !apostas[index].under) ? Text("Apostando no ${apostas[index].apostaTime1 ? BettingScreen.time1 : BettingScreen.time2}", style: TextStyle(color: Colors.white)) : Container(),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Odd: " + apostas[index].odd.toString(), style: TextStyle(color: Colors.white)),
                                  (!apostas[index].over && !apostas[index].under) ? Text("Inicial: " + (BettingScreen.time1.length > 3 ? BettingScreen.time1.substring(0, 3) : BettingScreen.time1) + " " + (apostas[index].time1scoreInicial.toInt()).toString() + " x " + (apostas[index].time2scoreInicial.toInt()).toString() + " " + (BettingScreen.time2.length > 3 ? BettingScreen.time2.substring(0, 3) : BettingScreen.time2), style: TextStyle(color: Colors.white)) : Container(),
                                ],
                              ),
                              Container(
                                child: IconButton(icon: Icon(Icons.delete_outline,  color: Colors.white,), onPressed: () => removerAposta(index)),
                              )
                            ],
                          ),
                          index == apostas.length-1 ? Container(height: 60) : Container()
                        ],
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addBet,
        tooltip: 'Adicionar Aposta',
        backgroundColor: Colors.white70,
        child: Icon(Icons.add, color: Colors.blueGrey),
      ),
    );
  }

  void _addBet() async {

    if(BettingScreen.time1 == null){
      MyAlert.alert(context, "Adicione os times", "Antes de criar uma aposta, adicione os times do jogo", btnPos: "OK", btnNeg: "Cancelar", clickYes: () async {
        List<String> times = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SelecionarTimesScream()));
        setState(() {
          BettingScreen.time1 = times[0];
          BettingScreen.time2 = times[1];
        });
      });
    }else {
      Aposta aposta = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddBetScreen()));
      setState(() {
        if (aposta != null) apostas.add(aposta);
        if(aposta.time1scoreInicial > minScoreTime1) minScoreTime1 = aposta.time1scoreInicial.toInt();
        if(aposta.time2scoreInicial > minScoreTime2) minScoreTime2 = aposta.time2scoreInicial.toInt();
      });
    }
  }

  int count = 0;

  getColor(double valor) {
   if(valor == 0) return Colors.blueGrey;
   if(valor > 0) {
     return Colors.green[400];
   }
   if(valor < 0) {
     return Colors.red[400];
   }
  }

  double getSomaValoresApostas(double scoreTime1, double scoreTime2) {
    double total = 0;
    for(Aposta aposta in apostas){
      total += aposta.getValor(scoreTime1, scoreTime2);
    }
    return total;
  }

  removerAposta(int index) {
    setState(() {
      apostas.removeAt(index);
    });

    minScoreTime1 = 0;
    minScoreTime2 = 0;

    for(Aposta aposta in apostas){
      if(aposta.time1scoreInicial > minScoreTime1) minScoreTime1 = aposta.time1scoreInicial.toInt();
      if(aposta.time2scoreInicial > minScoreTime2) minScoreTime2 = aposta.time2scoreInicial.toInt();
    }
  }
}

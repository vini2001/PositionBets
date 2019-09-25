class Aposta{
  double valor;
  double odd;
  double handicapTime1;
  double time1scoreInicial = 0;
  double time2scoreInicial = 0;
  bool apostaTime1 = false;

  bool over = false;
  bool under = false;

  double getValor(double time1score, double time2score){

    if(!apostaTime1){
      double aux = time2score;
      time2score = time1score;
      time1score = aux;
    }

    double valor = this.valor;

    if(apostaTime1){
      time1score -= time1scoreInicial;
      time2score -= time2scoreInicial;
    }else{
      time1score -= time2scoreInicial;
      time2score -= time1scoreInicial;
    }

    if(over){
      double soma = time1score+time2score;
      soma -= handicapTime1;

      if(soma == 0.25) { //ganhou metade
        valor *= (odd-1);
        valor /= 2;
        return valor;
      }
      if(soma >= 0.5){ //ganhou
        valor *= (odd-1);
        return valor;
      }
      if(soma == -0.25){ //perdeu metade
        valor /= 2;
        valor *= -1;
        return valor;
      }

      if(soma <= -0.5){ //perdeu
        valor *= -1;
        return valor;
      }
      return 0;
    }

    if(under){
      double soma = time1score+time2score;
      soma = handicapTime1 - soma;

      if(soma == 0.25) { //ganhou metade
        valor *= (odd-1);
        valor /= 2;
        return valor;
      }
      if(soma >= 0.5){ //ganhou
        valor *= (odd-1);
        return valor;
      }
      if(soma == -0.25){ //perdeu metade
        valor /= 2;
        valor *= -1;
        return valor;
      }

      if(soma <= -0.5){ //perdeu
        valor *= -1;
        return valor;
      }
      return 0;
    }

    double t1Dif = time1score-time2score;
    t1Dif += handicapTime1;

    if(t1Dif >= 0.5){ //ganhou
      valor *= (odd-1);
      return valor;
    }

    if(t1Dif == 0.25){ //ganhou metade
      valor *= (odd-1);
      valor /= 2;
      return valor;
    }

    if(t1Dif == -0.25){ //perdeu metade
      valor /= 2;
      valor *= -1;
      return valor;
    }

    if(t1Dif <= -0.5){ //perdeu
      valor *= -1;
      return valor;
    }

    return 0;
  }

  String getModalidade() {
    if(over) return "Over";
    if(under) return "Under";
    return "Handcap";
  }
}
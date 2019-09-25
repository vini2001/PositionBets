import 'dart:math';

class Formatacao{


  static String getStringMoney(double money) {
    money = dp(money, 2);
    String str = money.toString();
    int indexPonto = str.indexOf(",");
    if(indexPonto == -1) indexPonto = str.indexOf(".");
    int tam = str.length;
    if(indexPonto == tam-2) str += "0";
    str = str.replaceAll(".", ",");
    return "R\$ "+str;
  }

  static double dp(double val, double places){
    double mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }

  static String getKMFromMeters(String meters){
    double km = double.parse(meters)/1000.0;
    String str = km.toString();
    int indexPonto = str.indexOf(",");
    if(indexPonto == -1) indexPonto = str.indexOf(".");
    str = str.substring(0, indexPonto+2);
    return str.replaceAll(".", ",") + " KM";
  }

  static removeSpecialCharSimple(String strToReplace) {
    String strSChar = "áàãâäéèêëíìîïóòõôöúùûüçÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÖÔÚÙÛÜÇ";
    String strNoSChars = "aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC";

    var newStr = "";
    for (var i = 0; i < strToReplace.length; i++) {
      int index = strSChar.indexOf(strToReplace[i]);
      if (index != -1) {
        newStr += strNoSChars[index];
      } else {
        newStr += strToReplace[i];
      }
    }

    return newStr;
  }

  static String getStringVolume(int volumeEmbalagem) {
    if(volumeEmbalagem < 1000) return volumeEmbalagem.toString() + "ml";
    else return (volumeEmbalagem/1000.0).toString() + "L";
  }

  static String formatarDateTime(DateTime dataAgendamento) {
    String ano = dataAgendamento.year.toString();
    String mes = dataAgendamento.month.toString();
    String dia = dataAgendamento.day.toString();
    String hora = dataAgendamento.hour.toString();
    String minuto = dataAgendamento.minute.toString();

    if(mes.length == 1) mes = "0"+mes;
    if(dia.length == 1) dia = "0"+dia;
    if(hora.length == 1) hora = "0"+hora;
    if(minuto.length == 1) minuto = "0"+minuto;

    return dia + "/" + mes + "/" + ano + " - " + hora + ":" + minuto;
  }


  static getUfPorEstado(String estado) {
    List<String> estados = ["Acre",    "Alagoas",    "Amapá",    "Amazonas",    "Bahia",    "Ceará",    "Distrito Federal",    "Espírito Santo",    "Goiás",    "Maranhão",    "Mato Grosso",    "Mato Grosso do Sul", "Minas Gerais", "Pará", "Paraíba", "Paraná", "Pernambuco", "Piauí", "Rio de Janeiro", "Rio Grande do Norte", "Rio Grande do Sul", "Rondônia", "Roraima", "Santa Catarina", "São Paulo", "Sergipe", "Tocantins"];
    List<String> siglas = ["AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA", "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO"];

    for(int i = 0; i < estados.length; i++){
      if(estados[i] == estado) return siglas[i];
    }
    return "";
  }





}
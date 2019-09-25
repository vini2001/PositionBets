
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';


class MoneyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    String value = newValue.text.replaceAll(',', '');


    bool achou = false;
    for(int i = 0; i < value.length; i++){
      if(value[i] != '0'){
        value = value.substring(i);
        achou = true;
        break;
      }
    }
    if(!achou) value = "";

    int valueLength = value.length;
    for(int i = 0; i < 3-valueLength; i++){
      value = "0"+value;
    }

    var dateText = _addSeperators(value, ',');
    return newValue.copyWith(text: dateText, selection: updateCursorPosition(dateText));
  }

  String _addSeperators(String value, String seperator) {
    var newString = '';
    for (int i = 0; i < value.length; i++) {
      newString += value[i];
      if (i == value.length-3) {
        newString += seperator;
      }
    }
    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}

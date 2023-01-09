  import 'package:calculator/utils/screen_data.dart';
  import 'package:intl/intl.dart';
  
  bool isOpr(String x) {
    if (x == '÷' || x == 'x' || x == '-' || x == '=' || x == '+') {
      return true;
    }
    return false;
  }

  ///evaluates math expression in {
  void evaluate(String e) {
    double val = 0;
    double temp1 = 0;
    String arg1 = '', arg2 = '', opr = '';                //temp vars to store opretator and operands

    e = e.replaceAll('x', '*').replaceAll('÷', '/'); 

    int j = 0;

    //store first number in arg1
    while (RegExp(r'^[0-9]+$').hasMatch(e[j]) || e[j] == '.') {
      arg1 += e[j];
      j++;
    }

    val = double.parse(arg1);

    for (int i = j; i < e.length;) {
      opr = e[i];
      i++;
      //store next number in arg2
      while (i < e.length && (RegExp(r'^[0-9]+$').hasMatch(e[i]) || e[i] == '.')) {
        arg2 += e[i];
        i++;
      }

      temp1 = double.parse(arg2);

      if (opr == '+') {
        val += temp1;
      } else if (opr == '-') {
        val -= temp1;
      } else if (opr == '*') {
        val *= temp1;
      } else if (opr == '/') {
        val /= temp1;
      }
      arg2 = '';
    }
    final f = NumberFormat();
    f.minimumFractionDigits = 0;
    // f.maximumFractionDigits = 10;
    f.maximumSignificantDigits = 13;
    f.maximumIntegerDigits=13;
    curr = f.format(val);
  }

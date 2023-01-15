import 'package:calculator/utils/screen_data.dart';
import 'logic_provider.dart';

/// Provides functions for the respective buttons
class ButtonProvider {
  //clears expr and curr
  static void acButton() {
    counter = 13;
    expr = '';
    curr = '0';
  }

  //replaces + with - and vice-versa
  static void plusMinus() {
    if (curr[0] == '-') {
      expr = expr.substring(0, expr.length - curr.length);
      curr = curr.substring(1);
      expr += curr;
    } else {
      expr = expr.substring(0, expr.length - curr.length);
      curr = '-$curr';
      expr += curr;
    }
  }

  //returns percentage of curr
  static void percentage() {
    val = double.parse(curr);
    expr = expr.substring(0, expr.length - curr.length);
    val = val / 100;
    curr = val.toString();
    expr += curr;
  }

  //deletes the last char from expr and char
  static void delete() {
    if (curr == '0') {
    } else {
      if (isOpr(expr[expr.length - 1])) {
        flag=0;
        counter = counterHist;
        expr = expr.substring(0, expr.length - 1);
      } else {
        counter++;
        expr = expr.substring(0, expr.length - 1);
        curr = curr.substring(0, curr.length - 1);
        if (curr == '') {
          curr = '0';
        }
      }
    }
  }

  //evaluates expr
  static void equal() {
    evaluate(expr);
    expr = curr;
    flag1 = 0;
    counter = 13;
  }
}

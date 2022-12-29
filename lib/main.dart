import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Calculator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String expr = '';
  String curr = '0';
  int flag = 0;
  int flag1 = 0;
  double val = 0.0;
  final List<String> buttons = [
    'AC',
    '+/-',
    '%',
    '÷',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    'DEL',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        minimum: const EdgeInsets.all(6.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                decoration: BoxDecoration(
                  color: Colors.greenAccent[400],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        alignment: Alignment.centerRight,
                        child: Text(
                          expr,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        alignment: Alignment.centerRight,
                        child: Text(
                          curr,
                          style: const TextStyle(
                            fontSize: 47,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 2,
              child: GridView.builder(
                // padding: const EdgeInsets.all(5.0),
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  //AC bttn
                  if (index == 0) {
                    return Bttn(
                      ontap: () {
                        setState(() {
                          expr = '';
                          curr = '0';
                        });
                      },
                      bttnTxt: buttons[index],
                      color: Colors.red[800],
                      txtColor: Colors.black,
                    );
                  }
                  //+/- bttn
                  else if (index == 1) {
                    return Bttn(
                      ontap: () {
                        setState(() {
                          if (curr[0] == '-') {
                            expr = expr.substring(0, expr.length - curr.length);
                            curr = curr.substring(1);
                            expr += curr;
                          } else {
                            expr = expr.substring(0, expr.length - curr.length);
                            curr = '-$curr';
                            expr += curr;
                          }
                        });
                      },
                      bttnTxt: buttons[index],
                      color: Colors.grey[700],
                      txtColor: Colors.black,
                    );
                  }
                  //% bttn
                  else if (index == 2) {
                    return Bttn(
                      ontap: () {
                        setState(() {
                          val = double.parse(curr);
                          expr = expr.substring(0, expr.length - curr.length);
                          val = val / 100;
                          curr = val.toString();
                          expr += curr;
                        });
                      },
                      bttnTxt: buttons[index],
                      color: Colors.grey[700],
                      txtColor: Colors.black,
                    );
                  }
                  //DEL bttn
                  else if (index == 18) {
                    return Bttn(
                      ontap: () {
                        setState(() {
                          if (curr == '') {
                          } else {
                            expr = expr.substring(0, expr.length - 1);
                            curr = curr.substring(0, curr.length - 1);
                          }
                        });
                      },
                      bttnTxt: buttons[index],
                      color: Colors.grey[400],
                      txtColor: Colors.black,
                    );
                  }
                  //equal bttn
                  else if (index == 19) {
                    return Bttn(
                      ontap: () {
                        setState(() {
                          evaluate(expr);
                          expr = curr;
                          flag1 = 0;
                        });
                      },
                      bttnTxt: buttons[index],
                      color: Colors.grey[700],
                      txtColor: Colors.black,
                    );
                  } else if (index == 17) {
                    return Bttn(
                      ontap: () {
                        setState(() {
                          if (flag1 == 0) {
                            expr += buttons[index];
                            curr += buttons[index];
                            flag1 = 1;
                          }
                        });
                      },
                      bttnTxt: buttons[index],
                      color: Colors.grey[400],
                      txtColor: Colors.black,
                    );
                  } else {
                    return Bttn(
                      ontap: () {
                        setState(() {
                          if (isOpr(buttons[index]) && flag == 0) {
                            expr += buttons[index];
                            flag = 1;
                            flag1 = 0;
                          } else if (!(isOpr(buttons[index]))) {
                            expr += buttons[index];
                            if (curr == '0' || flag == 1) {
                              curr = '';
                              flag = 0;
                            }
                            curr += buttons[index];
                            flag = 0;
                          }
                        });
                      },
                      bttnTxt: buttons[index],
                      color: isOpr(buttons[index])
                          ? Colors.grey[700]
                          : Colors.grey[400],
                      txtColor: Colors.black,
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isOpr(String x) {
    if (x == '÷' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void evaluate(String e) {
    double val = 0;
    double temp1 = 0;
    String arg1 = '', arg2 = '', opr = '';
    e = e.replaceAll('x', '*').replaceAll('÷', '/');

    int j = 0;
    while (RegExp(r'^[0-9]+$').hasMatch(e[j]) || e[j] == '.') {
      arg1 += e[j];
      j++;
    }
    val = double.parse(arg1);

    for (int i = j; i < e.length;) {
      opr = e[i];
      i++;
      while (
          i < e.length && (RegExp(r'^[0-9]+$').hasMatch(e[i]) || e[i] == '.')) {
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
    f.maximumFractionDigits = 10;
    curr = f.format(val);
  }
}

class Bttn extends StatelessWidget {
  final color;
  final txtColor;
  final String bttnTxt;
  final ontap;

  const Bttn(
      {super.key,
      this.color,
      this.txtColor,
      required this.bttnTxt,
      this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Center(
          child: Text(
            bttnTxt,
            style: TextStyle(
              color: txtColor,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}

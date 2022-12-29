/*import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
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
      backgroundColor: const Color.fromARGB(255, 63, 3, 33),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 29,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 122, 7, 66),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      expr,
                      style: const TextStyle(
                        fontSize: 25,
                        color: Colors.grey,
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
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
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
                    color: Colors.amber[800],
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
                    color: Colors.pink[400],
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
                    color: Colors.pink[400],
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
                    color: Colors.pink[900],
                    txtColor: Colors.black,
                  );
                }
                //equal bttn
                else if (index == 19) {
                  return Bttn(
                    ontap: () {
                      setState(() {
                        evaluate();
                        expr=curr;
                      });
                    },
                    bttnTxt: buttons[index],
                    color: Colors.pink[400],
                    txtColor: Colors.black,
                  );
                } else {
                  return Bttn(
                    ontap: () {
                      setState(() {
                        expr += buttons[index];
                        if (isOpr(buttons[index])) {
                          flag = 1;
                        } else {
                          if (curr == '0' || flag == 1) {
                            curr = '';
                            flag = 0;
                          }
                          curr += buttons[index];
                        }
                      });
                    },
                    bttnTxt: buttons[index],
                    color: isOpr(buttons[index])
                        ? Colors.pink[400]
                        : Colors.pink[900],
                    txtColor: Colors.black,
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  bool isOpr(String x) {
    if (x == '÷' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void evaluate() {
    String inp = expr;
    inp = expr.replaceAll('x', '*').replaceAll('÷', '/');
    final f = NumberFormat();

    Parser p = Parser();
    ContextModel cm = ContextModel();
    Expression exp = p.parse(inp);
    double ans = exp.evaluate(EvaluationType.REAL, cm);
    f.minimumFractionDigits = 0;
    f.maximumFractionDigits = 10;
    // curr = ans.toString();
    curr = f.format(ans);
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
*/

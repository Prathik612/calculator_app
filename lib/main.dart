import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:calculator/Widgets/bttn.dart';
import 'package:calculator/utils/utils.dart';
import 'package:calculator/provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bkGround,
      body: SafeArea(
        minimum: const EdgeInsets.all(6.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                decoration: BoxDecoration(
                  color: AppTheme.displayColor,
                  borderRadius: BorderRadius.circular(30),
                ),
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
                          // overflow: TextOverflow.ellipsis
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
                            overflow: TextOverflow.ellipsis),
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
                  //  (AC) (+/-) (%) (DEL) (EQL) buttons
                  if (index == 0 ||
                      index == 1 ||
                      index == 2 ||
                      index == 18 ||
                      index == 19) {
                    return Bttn(
                      ontap: () {
                        setState(() {
                          //(AC) button
                          if (index == 0) {
                            ButtonProvider.acButton();
                          }
                          //(+/-) button
                          else if (index == 1) {
                            ButtonProvider.plusMinus();
                          }
                          //(%) button
                          else if (index == 2) {
                            ButtonProvider.percentage();
                          }
                          //(DEL) button
                          else if (index == 18) {
                            ButtonProvider.delete();
                          }
                          //(EQL) button
                          else if (index == 19) {
                            ButtonProvider.equal();
                          }
                        });
                      },
                      bttnTxt: buttons[index],
                      color: index == 0
                          ? ButtonColor.acButton
                          : ButtonColor.operatorButton,
                      txtColor: ButtonColor.textColor,
                    );
                  } else {
                    return Bttn(
                      ontap: () {
                        setState(() {
                          // (.) button
                          if (index == 17) {
                            if (flag1 == 0) {
                              expr += buttons[index];
                              curr += buttons[index];
                              flag1 = 1;
                            }
                          } else {
                            //initial oprator press
                            if (isOpr(buttons[index]) && flag == 0) {
                              counterHist = counter;
                              counter = 13;
                              expr += buttons[index];
                              flag = 1;
                              flag1 = 0;
                            }
                            //consecutive operator press (replaces prev. operator)
                            else if (isOpr(buttons[index]) && flag == 1) {
                              expr = expr.substring(0, expr.length - 1);
                              expr += buttons[index];
                            }
                            //number buttons
                            else if (!(isOpr(buttons[index])) && counter > 0) {
                              counter--;
                              expr += buttons[index];
                              if (curr == '0' || flag == 1) {
                                curr = '';
                                flag = 0;
                              }
                              curr += buttons[index];
                              flag = 0;
                            }
                          }
                        });
                      },
                      bttnTxt: buttons[index],
                      color: isOpr(buttons[index])
                          ? ButtonColor.operatorButton
                          : ButtonColor.numberButton,
                      txtColor: ButtonColor.textColor,
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
}

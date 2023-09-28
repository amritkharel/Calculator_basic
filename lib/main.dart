import 'package:flutter/material.dart';
import 'package:calculator/buttons.dart';
import 'dart:math';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(
      MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalcHome(),
    )
  );
}

class CalcHome extends StatefulWidget {
  @override
  State<CalcHome> createState() => _CalcHomeState();
}

class _CalcHomeState extends State<CalcHome> {

  var userQuestion = '';
  var userAnswer = '';

  final List<String> buttons = [
    'C','DEL', '%', '/',
    '9', '8', '7', '*',
    '6', '5', '4', '-',
    '3', '2', '1', '+',
    '0', '.', 'ANS', '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: SingleChildScrollView(

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(height: 50,),
                    Container(
                        padding: const EdgeInsets.all(20.0),
                        alignment: Alignment.centerRight,
                        child: Text(
                            userQuestion,
                            style: const TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                            ),
                        ),
                    ),
                    Container(
                        padding: const EdgeInsets.all(20.0),
                        alignment: Alignment.centerRight,
                        child: Text(
                            userAnswer,
                            style: const TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                          ),
                        ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 0.0),
              child: Center(
                child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index){
                    //When Clear is pressed
                    if(index == 0){
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userQuestion = '';
                            userAnswer = '';
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.black,
                        textColor: Colors.white,
                      );
                    }
                    //When Delete is pressed
                    else if(index == 1){
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            if(userQuestion.isNotEmpty){
                              userQuestion = userQuestion.substring(0,userQuestion.length-1);
                            }
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.black,
                        textColor: Colors.white,
                      );
                    }
                    //When equals to is pressed
                    else if(index == buttons.length-1){
                      return MyButton(
                        buttonTapped: () {
                          if(userQuestion.isNotEmpty){
                            setState(() {
                              finalAnswer();
                            });
                          }
                          },

                        buttonText: buttons[index],
                        color: Colors.green,
                        textColor: Colors.white,
                      );
                    }
                    else{
                      return MyButton(
                        buttonTapped: () {
                          if(index != buttons.length-2) {
                            setState(() {
                              userQuestion += buttons[index];
                            });
                          }
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index]) ? Colors.black : Colors.grey[300],
                        textColor: isOperator(buttons[index]) ? Colors.white : Colors.black,
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  bool isOperator(String x){
    if(x=='%' || x=='/' || x=='-' || x=='+' || x=='*' || x=='='){
      return true;
    }
    return false;
  }

  void finalAnswer(){
    String finalQuestion = userQuestion;
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }

}





import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculater',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: simplecalculater(),
    );
  }
}
class simplecalculater extends StatefulWidget {
  const simplecalculater({Key? key}) : super(key: key);

  @override
  State<simplecalculater> createState() => _simplecalculaterState();
}

class _simplecalculaterState extends State<simplecalculater> {
  String equation = '0';
  String result ='0';
  String expression ="";
  double equationfontsize =30.0;
  double resultfontsize =40.0;
  buttonPressed(buttonText){
    setState(() {
      if(buttonText =="C"){
        equation ="0";
        result ="0";
        equationfontsize =30.0;
        resultfontsize =40.0;
      }
      else if(buttonText == "DEl"){
        equationfontsize =40.0;
        resultfontsize =30.0;
        equation = equation.substring(0,equation.length - 1);
        if (equation==""){
          equation ="0";
        }
      }else if (buttonText == "="){
        equationfontsize =30.0;
        resultfontsize =40.0;
        expression =equation;
        expression = expression.replaceAll("÷", "/");
        expression =expression.replaceAll("x", "*");
        try{
          Parser p =  Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result= '${exp.evaluate(EvaluationType.REAL, cm)}';
        }
        catch(e){
          result ="ERROR";
        }
      }else {
        equationfontsize =40.0;
        resultfontsize =30.0;
        if (equation=="0"){
          equation = buttonText;
        }else{
          equation = equation + buttonText;
        }}
    });
  }
  Widget buildButtom(String buttonText,double buttonHeight , Color buttonColor){
    return  Container(
        height: MediaQuery.of(context).size.width * 0.1 * buttonHeight,
        color: buttonColor,
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(color: Colors.white,width:0,style: BorderStyle.solid)
          ),
          padding: EdgeInsets.all(10.0),
          onPressed:()=> buttonPressed(buttonText),
          child: Text(buttonText,
            style: TextStyle(fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),),
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('simple calculater'),),
      body: Column(
        children:<Widget> [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 20, 0),
            child: Text(equation,style: TextStyle(fontSize: equationfontsize),),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 20, 0),
            child: Text(result,style: TextStyle(fontSize: equationfontsize),),
          ),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButtom('C', 2, Colors.green),
                        buildButtom('DEL', 2, Colors.green),
                        buildButtom('%', 2, Colors.green),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButtom('9', 2, Colors.grey),
                        buildButtom('8', 2, Colors.grey),
                        buildButtom('7', 2, Colors.grey),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButtom('6', 2, Colors.grey),
                        buildButtom('5', 2, Colors.grey),
                        buildButtom('4', 2, Colors.grey),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButtom('3', 2, Colors.grey),
                        buildButtom('2', 2, Colors.grey),
                        buildButtom('1', 2, Colors.grey),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButtom('0', 2, Colors.grey),
                        buildButtom('.', 2, Colors.green),
                        buildButtom('ANS', 2, Colors.green),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButtom('x', 2, Colors.green),
                      ],

                    ),
                    TableRow(
                        children: [
                          buildButtom('-', 2, Colors.green),
                        ]),
                    TableRow(
                        children: [
                          buildButtom('+', 2, Colors.green),
                        ]),
                    TableRow(
                        children: [
                          buildButtom('=', 4, Colors.lightGreen),
                        ]),
                  ],
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}


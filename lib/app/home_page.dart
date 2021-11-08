import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  String a = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: getContent(), // Will get the content from getContent method
      ),
      backgroundColor: Colors.black87,
    );
  }

  Column getContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        getResultContainer(), // will return the container containing result
        SizedBox(
          height: 40.0,
        ),
        getNumberAndOperationsContainer([
          "7",
          "8",
          "9",
          "+"
        ]), // will create a row of buttons with 7,8,9,+
        SizedBox(
          height: 15.0,
        ),
        getNumberAndOperationsContainer([
          "4",
          "5",
          "6",
          "-"
        ]), // will create a row of buttons with 4,5,6,-
        SizedBox(
          height: 15.0,
        ),
        getNumberAndOperationsContainer([
          "1",
          "2",
          "3",
          "*"
        ]), // will create a row of buttons with 1,2,3,*
        SizedBox(
          height: 15.0,
        ),
        getNumberAndOperationsContainer([
          "AC",
          "0",
          "=",
          "/"
        ]), // will create a row of buttons with =,0,AC,/
      ],
    );
  }

  // method which will return the specified List Buttons
  Container getNumberAndOperationsContainer(List<String> li) {
    return Container(
      child: SizedBox(
        height: 60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            getButton(li[0]),
            getButton(li[1]),
            getButton(li[2]),
            getButton(li[3]),
          ],
        ),
      ),
    );
  }

  // will return container containing result
  Column getResultContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          // color: Colors.grey[300],
          child: SizedBox(
            height: 60,
            child: Text(
              a,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 37,
                color: Colors.blue[400],
              ),
            ),
          ),
        )
      ],
    );
  }

  // will return the button with specified string
  Widget getButton(String s) {
    if (s == "=") {
      return RaisedButton(
        color: Colors.blue[400],
        shape: CircleBorder(side: BorderSide.none),
        onPressed: () {
          if (s == "=") {
            try {
              Expression expression = Expression.parse(a);
              final evaluator = const ExpressionEvaluator();
              var r = evaluator.eval(expression, null);
              print(r);
              setState(() {
                a = r.toString();
              });
            } catch (e) {
              setState(() {
                a = "";
              });
              print(e);
            }
            return;
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getText(s),
          ],
        ),
      );
    } else {
      return RaisedButton(
        highlightColor: Colors.grey[300],
        focusColor: Colors.grey[300],
        shape: CircleBorder(side: BorderSide.none),
        color: Colors.black87,
        onPressed: () {
          if (s == "AC") {
            setState(() {
              a = "";
            });
            return;
          }
          setState(() {
            a += s;
          });
        },
        child: getText(s),
      );
    }
  }

  Text getText(String s) {
    if (s == "=") {
      return Text(
        s,
        style: TextStyle(
          fontSize: 32.0,
          color: Colors.grey[200],
        ),
      );
    }
    if (s == "+" || s == "-" || s == "*" || s == "/" || s == "AC") {
      return Text(
        s,
        style: TextStyle(
          fontSize: 32.0,
          color: Colors.blue[400],
        ),
      );
    } else {
      return Text(
        s,
        style: TextStyle(
          fontSize: 32.0,
          color: Colors.grey[400],
        ),
      );
    }
  }
}

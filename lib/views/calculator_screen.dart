import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorScreen> {
  final _textController = TextEditingController();
  List<String> lstSymbols = [
    "C",
    "*",
    "/",
    "<-",
    "1",
    "2",
    "3",
    "+",
    "4",
    "5",
    "6",
    "-",
    "7",
    "8",
    "9",
    "*",
    "%",
    "0",
    ".",
    "=",
  ];

  String input = "";
  double? firstOperand;
  double? secondOperand;
  String? operation;

  void _onButtonPressed(String symbol) {
    setState(() {
      if (symbol == "C") {
        // Clear Screen
        input = "";
        firstOperand = null;
        secondOperand = null;
        operation = null;
      } else if (symbol == "<-") {
        // Delete
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1);
        }
      } else if (symbol == "=") {
        // Calculate the result
        if (firstOperand != null && operation != null && input.isNotEmpty) {
          secondOperand = double.tryParse(input);
          if (secondOperand != null) {
            switch (operation) {
              case "+":
                input = (firstOperand! + secondOperand!).toString();
                break;
              case "-":
                input = (firstOperand! - secondOperand!).toString();
                break;
              case "*":
                input = (firstOperand! * secondOperand!).toString();
                break;
              case "/":
                input = secondOperand != 0
                    ? (firstOperand! / secondOperand!).toString()
                    : "Error";
                break;
              case "%":
                input = (firstOperand! % secondOperand!).toString();
                break;
              default:
                break;
            }
          }
          firstOperand = null;
          operation = null;
        }
      } else if (["+", "-", "*", "/", "%"].contains(symbol)) {
        if (input.isNotEmpty) {
          firstOperand = double.tryParse(input);
          operation = symbol;
          input = "";
        }
      } else {
        input += symbol;
      }
      _textController.text = input;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sandesh Sapkota Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                textDirection: TextDirection.rtl,
                controller: _textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                readOnly: true, // Prevent manual input
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: lstSymbols.length,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 65, 1, 1),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => _onButtonPressed(lstSymbols[index]),
                      child: Text(
                        lstSymbols[index],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
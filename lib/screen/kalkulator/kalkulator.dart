import 'package:flutter/material.dart';
import 'package:kalkulator_beta_01/screen/kalkulator/bagian/button_values.dart';

class Kalkulator extends StatefulWidget {
  const Kalkulator({super.key});

  @override
  State<Kalkulator> createState() => _KalkulatorState();
}

class _KalkulatorState extends State<Kalkulator> {
  String nomor1 = ''; // . 0-9
  String operand = ''; // + -*
  String nomor2 = ''; // . 0-9

  @override
  Widget build(BuildContext context) {
    final responsive = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(12),
                child: Text(
                  '$nomor1$operand$nomor2'.isEmpty
                      ? '0'
                      : '$nomor1$operand$nomor2',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
          ),
          Wrap(
            children: Btn.buttonValues
                .map(
                  (value) => SizedBox(
                    width: value == Btn.n0
                        ? responsive.width / 2
                        : (responsive.width / 4),
                    height: responsive.width / 5,
                    child: buildButton(value),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }

  Widget buildButton(value) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: getColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            12,
          ),
        ),
        child: InkWell(
          onTap: () => onBtn(value),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                color: getColorText(value),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onBtn(String value) {
    if (value == Btn.del) {
      delete();
      return;
    }

    if (value == Btn.clr) {
      clearAll();
      return;
    }

    if (value == Btn.per) {
      convertToPercentage();
      return;
    }

    if (value == Btn.calculate) {
      calculate();
      return;
    }

    appendValue(value);
  }

  void calculate() {
    if (nomor1.isEmpty) return;
    if (operand.isEmpty) return;
    if (nomor2.isEmpty) return;

    final double num1 = double.parse(nomor1);
    final double num2 = double.parse(nomor2);

    var result = 0.0;
    switch (operand) {
      case Btn.add:
        result = num1 + num2;
        break;
      case Btn.subtract:
        result = num1 - num2;
        break;
      case Btn.multiply:
        result = num1 * num2;
        break;
      case Btn.divide:
        result = num1 / num2;
        break;
      default:
    }

    setState(() {
      nomor1 = result.toStringAsPrecision(3);

      if (nomor1.endsWith(".0")) {
        nomor1 = nomor1.substring(0, nomor1.length - 2);
      }

      operand = "";
      nomor2 = "";
    });
  }

  void convertToPercentage() {
    if (nomor1.isNotEmpty && operand.isNotEmpty && nomor2.isNotEmpty) {
      calculate();
    }

    if (operand.isNotEmpty) {
      return;
    }

    final number = double.parse(nomor1);
    setState(() {
      nomor1 = "${(number / 100)}";
      operand = "";
      nomor2 = "";
    });
  }

  void clearAll() {
    setState(() {
      nomor1 = "";
      operand = "";
      nomor2 = "";
    });
  }

  void delete() {
    if (nomor2.isNotEmpty) {
      nomor2 = nomor2.substring(0, nomor2.length - 1);
    } else if (operand.isNotEmpty) {
      operand = "";
    } else if (nomor1.isNotEmpty) {
      nomor1 = nomor1.substring(0, nomor1.length - 1);
    }

    setState(() {});
  }

  void appendValue(String value) {
    if (value != Btn.dot && int.tryParse(value) == null) {
      if (operand.isNotEmpty && nomor2.isNotEmpty) {
        calculate();
      }
      operand = value;
    } else if (nomor1.isEmpty || operand.isEmpty) {
      if (value == Btn.dot && nomor1.contains(Btn.dot)) return;
      if (value == Btn.dot && (nomor1.isEmpty || nomor1 == Btn.n0)) {
        value = "0.";
      }
      nomor1 += value;
    } else if (nomor2.isEmpty || operand.isNotEmpty) {
      if (value == Btn.dot && nomor2.contains(Btn.dot)) return;
      if (value == Btn.dot && (nomor2.isEmpty || nomor2 == Btn.n0)) {
        value = "0.";
      }
      nomor2 += value;
    }

    setState(() {});
  }

  Color getColorText(value) {
    return [
      Btn.per,
      Btn.multiply,
      Btn.add,
      Btn.subtract,
      Btn.divide,
      Btn.calculate,
    ].contains(value)
        ? Colors.white
        : Colors.black;
  }

  Color getColor(value) {
    return [Btn.del, Btn.clr].contains(value)
        ? const Color.fromARGB(212, 211, 239, 1000)
        : [
            Btn.per,
            Btn.multiply,
            Btn.add,
            Btn.subtract,
            Btn.divide,
            Btn.calculate,
          ].contains(value)
            ? const Color.fromARGB(144, 144, 177, 1000)
            : Colors.white;
  }
}

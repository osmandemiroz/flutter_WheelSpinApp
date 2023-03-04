import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_carkuygulamasi/constants/constants.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class SpinningWheelScreen extends StatefulWidget {
  var inputs = [];

  SpinningWheelScreen({super.key, required this.inputs});

  @override
  State<SpinningWheelScreen> createState() => _SpinningWheelScreenState();
}

class _SpinningWheelScreenState extends State<SpinningWheelScreen> {
  StreamController<int> selected = StreamController<int>();

  @override
  void dispose() {
    selected.close;
    super.dispose();
  }

  int randomNumber() {
    setState(() {
      _result = Fortune.randomInt(0, widget.inputs.length);
    });

    return _result;
  }

  void spin() {
    setState(() {
      selected.add(randomNumber());
    });
  }

  void remove(int number) {
    setState(() {
      if (widget.inputs.length > 2) {
        widget.inputs.removeAt(number);
        Navigator.of(context).pop();
      }
    });
  }

  final String _title = 'WheelSpin Screen';
  int _result = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              fortuneWheel(),
              spinButton(),
              const SizedBox(height: 30),
              goBackButton(context),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton goBackButton(BuildContext context) {
    return ElevatedButton.icon(
        icon: const Icon(Icons.arrow_back_outlined),
        onPressed: () {
          Navigator.of(context).pop();
        },
        label: const Text('Go Back'));
  }

  ElevatedButton spinButton() {
    return ElevatedButton(
      onPressed: spin,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.pressed)) {
          return Colors.lightGreenAccent;
        }
        return null;
      })),
      child: const Text('SPIN!'),
    );
  }

  Expanded fortuneWheel() {
    return Expanded(
      child: FortuneWheel(
        physics: CircularPanPhysics(
          duration: const Duration(seconds: 1),
          curve: Curves.decelerate,
        ),
        indicators: const <FortuneIndicator>[
          FortuneIndicator(
              alignment: Alignment.topCenter,
              child: TriangleIndicator(
                color: AppColors.primaryColor,
              ))
        ],
        animateFirst: false,
        items: [
          for (var i in widget.inputs)
            FortuneItem(
              child: Text(i,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Colors.white)),
            ),
        ],
        selected: selected.stream,
        onAnimationEnd: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'SELECTED',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                content: Text(
                  widget.inputs[_result].toString(),
                  style: const TextStyle(
                      color: AppColors.secondaryColor, fontSize: 35),
                ),
                actions: <Widget>[
                  ElevatedButton.icon(
                      onPressed: () => remove(_result),
                      icon: const Icon(Icons.remove_outlined),
                      label: const Text('Remove')),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

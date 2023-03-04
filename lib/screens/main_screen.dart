import 'package:flutter/material.dart';
import 'package:flutter_carkuygulamasi/constants/constants.dart';

import 'spinning_wheel_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with NavigatorManager {
  TextEditingController t1 = TextEditingController();
  void add() {
    setState(() {
      myList.add(t1.text);
      t1.clear();
    });
  }

 

  void delete() {
    if (myList.isNotEmpty) {
      setState(() {
        myList.removeLast();
      });
    }
  }

  var myList = [];

  final String _title = 'Main Screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                showInputs(context),
                const SizedBox(
                  height: 30,
                ),
                takeInputs(),
                const SizedBox(height: 30),
                addButton(context),
                const SizedBox(height: 15),
                nextPageButton(context),
                const SizedBox(height: 15),
                removeButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton removeButton() => ElevatedButton.icon(
        onPressed: delete,
        label: const Text('Remove'),
        icon: const Icon(Icons.remove_outlined),
      );

  ElevatedButton nextPageButton(BuildContext context) {
    return ElevatedButton.icon(
        icon: const Icon(Icons.navigate_next_outlined),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.lightGreenAccent;
          }
          return null;
        })),
        onPressed: () {
          if (myList.isNotEmpty && myList.length != 1) {
            navigateToWidget(context, SpinningWheelScreen(inputs: myList));
          } else if (myList.length == 1) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('ERROR'),
                  content: const Text('You can\'t sent one values'),
                  actions: <Widget>[
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
          }
        },
        label: const Text('Next'));
  }

  ElevatedButton addButton(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.add_outlined),
      style: Theme.of(context).elevatedButtonTheme.style,
      onPressed: add,
      label: const Text('Add'),
    );
  }

  TextFormField takeInputs() {
    return TextFormField(
      onFieldSubmitted: (value) => add(),
      decoration: InputDecoration(
          hintText: 'Enter Your Inputs',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(24))),
      controller: t1,
    );
  }

  Container showInputs(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 24),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
                colors: [AppColors.primaryColor, AppColors.secondaryColor])),
        child: Text(
          myList.toString(),
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.white),
        ));
  }
}

mixin NavigatorManager {
  void navigateToWidget(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }
}

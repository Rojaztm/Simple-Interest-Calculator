// ignore_for_file: deprecated_member_use, unnecessary_null_comparison

import 'package:flutter/material.dart';

class SimpleInterest extends StatefulWidget {
  const SimpleInterest({Key? key}) : super(key: key);

  @override
  State<SimpleInterest> createState() => _SimpleInterest();
}

class _SimpleInterest extends State<SimpleInterest> {
  var _formKey = GlobalKey<FormState>();

  final _currencies = ['Dollars', 'Pounds', 'Naira', 'Rand', 'Yen'];
  static const _minPadding = 10.0;
  String? _selectedItem = '';
  String displayAmount = '';

  TextEditingController? principalController = TextEditingController();
  TextEditingController? rateController = TextEditingController();
  TextEditingController? timeController = TextEditingController();
  TextEditingController? resultController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedItem = _currencies[0];
    displayAmount = '';
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? myTextStyle = Theme.of(context).textTheme.headline6;
    resultController!.text = displayAmount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Interest Calculator'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(_minPadding * 2),
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Image(
                  image: AssetImage('images/bank1.png'),
                  width: 125.0,
                  height: 125.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: _minPadding,
                ),
                child: TextFormField(
                  style: myTextStyle,
                  controller: resultController,
                  enabled: false,
                  readOnly: true,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: 'Result',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: _minPadding, bottom: _minPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: principalController,
                  validator: (String? value) {
                    if (value!.isEmpty ||
                        double.parse(value).isNaN ||
                        double.parse(value).isNegative) {
                      return 'Principal cannot be empty or negative';
                    }
                  },
                  style: myTextStyle,
                  decoration: InputDecoration(
                    label: const Text('Principal'),
                    labelStyle: myTextStyle,
                    errorStyle: TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 15.0,
                    ),
                    hintText: 'Enter the principal e.g. 200',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: _minPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: rateController,
                  validator: (String? value) {
                    if (value!.isEmpty ||
                        double.parse(value).isNaN ||
                        double.parse(value).isNegative) {
                      return 'Rate cannot be empty or negative';
                    }
                  },
                  style: myTextStyle,
                  decoration: InputDecoration(
                    label: const Text('Rate'),
                    labelStyle: myTextStyle,
                    errorStyle: TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 15.0,
                    ),
                    hintText: 'In percent',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: timeController,
                      validator: (String? value) {
                        if (value!.isEmpty ||
                            double.parse(value).isNaN ||
                            double.parse(value).isNegative) {
                          return 'Time cannot be empty or negative';
                        }
                      },
                      style: myTextStyle,
                      decoration: InputDecoration(
                        label: const Text('Time'),
                        labelStyle: myTextStyle,
                        errorStyle: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 15.0,
                        ),
                        hintText: 'In years',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: _minPadding * 5,
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                      items: _currencies.map((String myValue) {
                        return DropdownMenuItem<String>(
                          child: Text(myValue),
                          value: myValue,
                        );
                      }).toList(),
                      style: myTextStyle,
                      value: _selectedItem,
                      onChanged: (String? newValueSelected) {
                        setState(() {
                          _selectedItem = newValueSelected;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: _minPadding, bottom: _minPadding),
                child: Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        child: const Text(
                          'Calculate',
                          textScaleFactor: 1.4,
                        ),
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState!.validate()) {
                              displayAmount =
                                  amountOfSI(); //function is defined at the bottom of the class
                            }
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 10.0,
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: const Text(
                          'Reset',
                          textScaleFactor: 1.4,
                        ),
                        onPressed: () {
                          setState(() {
                            principalController!.text = '';
                            rateController!.text = '';
                            timeController!.text = '';
                            displayAmount = '';
                            _selectedItem = _currencies[0];
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String amountOfSI() {
    double principal = double.parse(principalController!.text);
    double rate = double.parse(rateController!.text);
    int time = int.parse(timeController!.text);
    double amount = principal + (principal * rate * time) / 100;
    String result =
        "The amount payable after $time years is $amount $_selectedItem";
    return result;
  }
}

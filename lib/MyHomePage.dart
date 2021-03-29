import 'dart:math';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _value = 1;
  double age = 0;
  double height, weight, waistCircumference, bmi, absi, zScore = 0;
  String message = "";
  String abSi = "";
  final TextEditingController ageController = new TextEditingController();
  final TextEditingController heightController = new TextEditingController();
  final TextEditingController weightController = new TextEditingController();
  final TextEditingController wcController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(this.widget.title),
      ),
      body: ListView(
        children: <Widget>[
          //Sex row
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text('Sex', style: TextStyle(fontSize: 18)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(200, 0, 0, 0),
                child: DropdownButton(
                    value: _value,
                    items: [
                      new DropdownMenuItem(
                        child: Text("Male"),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text("Female"),
                        value: 2,
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    }),
              ),
            ],
          ), //sex row

          SizedBox(
            height: 10,
          ),
          //age row
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 200, 0),
                child: Text('Age', style: TextStyle(fontSize: 18)),
              ),
              Container(
                width: 50,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'years',
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: ageController,
                ),
              ),
            ],
          ), //age row

          SizedBox(
            height: 10,
          ),
          //height row
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 180, 0),
                child: Text('Height', style: TextStyle(fontSize: 18)),
              ),
              Container(
                width: 50,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'cm',
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: heightController,
                ),
              ),
            ],
          ), //height row

          SizedBox(
            height: 10,
          ),
          //weight row
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 180, 0),
                child: Text('Weight', style: TextStyle(fontSize: 18)),
              ),
              Container(
                width: 50,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'kg',
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: weightController,
                ),
              ),
            ],
          ), //weight row

          SizedBox(
            height: 10,
          ),
          //waist circumference
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 70, 0),
                child:
                    Text('Waist circumference', style: TextStyle(fontSize: 18)),
              ),
              Container(
                width: 50,
                child: (TextField(
                  decoration: InputDecoration(
                    hintText: 'cm',
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: wcController,
                )),
              ),
            ],
          ), //waist circumference row

          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(
              '*Only available for 0 between 85 ages!',
              style: TextStyle(fontSize: 15),
            ),
          ),

          SizedBox(
            height: 10,
          ),
          //calculate button
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: ElevatedButton(
              child: Text('Calculate', style: TextStyle(fontSize: 18)),
              onPressed: _calculate,
            ),
          ),
          //reset button
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: ElevatedButton(
              child: Text('Reset', style: TextStyle(fontSize: 18)),
              onPressed: _reset,
            ),
          ),

          //result
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 200, 0),
            child: Text('Result :', style: TextStyle(fontSize: 20)),
          ),

          //absi
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 173, 0),
                child: Text('ABSI', style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Text('$absi', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
          //zScore
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
            child: Container(
                width: 220,
                child: Text('$message', style: TextStyle(fontSize: 20))),
          ),
        ],
      ),
    );
  }

  void _calculate() {
    setState(() {
      switch (_value) {
        case 1:
          double mean, sd = 0;
          waistCircumference = double.parse(wcController.text) / 100;
          height = double.parse(heightController.text) / 100;
          weight = double.parse(weightController.text);
          bmi = weight / (pow(height, 2));
          absi = waistCircumference / (pow(bmi, (2 / 3)) * pow(height, (2 / 3)));
          abSi = absi.toStringAsFixed(5);
          absi = double.parse(abSi);
          double num = double.parse(ageController.text);

          if (num >= 2 || num < 15) {
            mean = 0.078929;
            sd = 0.003816;
            zScore = (absi - mean) / sd;
            message = _suggestion(zScore);
          } else if (num >= 16 || num < 25) {
            mean = 0.07758;
            sd = 0.003772;
            zScore = (absi - mean) / sd;
            message = _suggestion(zScore);
          } else if (num >= 26 || num < 35) {
            mean = 0.079536;
            sd = 0.003735;
            zScore = (absi - mean) / sd;
            message = _suggestion(zScore);
          } else if (num >= 36 || num < 45) {
            mean = 0.08111;
            sd = 0.004067;
            zScore = (absi - mean) / sd;
            message = _suggestion(zScore);
          }
          break;
        case 2:
          double mean, sd = 0;
          waistCircumference = double.parse(wcController.text) / 100;
          height = double.parse(heightController.text) / 100;
          weight = double.parse(weightController.text);
          bmi = weight / (pow(height, 2));
          absi = waistCircumference / (pow(bmi, (2 / 3)) * pow(height, (2 / 3)));
          abSi = absi.toStringAsFixed(5);
          absi = double.parse(abSi);
          double num = double.parse(ageController.text);

          if (num >= 2 || num < 15) {
            mean = 0.078929;
            sd = 0.003816;
            zScore = (absi - mean) / sd;
            message = _suggestion(zScore);
          } else if (num >= 16 || num < 25) {
            mean = 0.07758;
            sd = 0.003772;
            zScore = (absi - mean) / sd;
            message = _suggestion(zScore);
          } else if (num >= 26 || num < 35) {
            mean = 0.079536;
            sd = 0.003735;
            zScore = (absi - mean) / sd;
            message = _suggestion(zScore);
          } else if (num >= 36 || num < 45) {
            mean = 0.08111;
            sd = 0.004067;
            zScore = (absi - mean) / sd;
            message = _suggestion(zScore);
          }
          break;
      }
    });
  } //calculate result

  void _reset() {
    setState(() {
      ageController.clear();
      heightController.clear();
      weightController.clear();
      wcController.clear();
      absi = 0;
    });
  }

  _suggestion(double zScore) {
    String suggest = "";
    if (zScore < -0.868) {
      return suggest =
          "According to your ABSI z score, your premature mortality risk is very low";
    } else if (zScore >= -0.868 && zScore < -0.272) {
      return suggest =
          "According to your ABSI z score, your premature mortality risk is low";
    } else if (zScore >= -0.272 && zScore < 0.229) {
      return suggest =
          "According to your ABSI z score, your premature mortality risk is average";
    } else if (zScore >= 0.229 && zScore < 0.798) {
      return suggest =
          "According to your ABSI z score, your premature mortality risk is high";
    } else if (zScore >= 0.798) {
      return suggest =
          "According to your ABSI z score, your premature mortality risk is very high";
    }
  }
} //end class MyHomePage

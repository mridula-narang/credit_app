import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugeExample extends StatefulWidget {
  @override
  _GaugeExampleState createState() => _GaugeExampleState();
}

class _GaugeExampleState extends State<GaugeExample> {
  double needleValue = 60.0;
  TextEditingController nameController = TextEditingController();
  String paymentOptions = ''; // Variable to store payment options statement

  void randomizePointer() {
    double randomValue = Random().nextDouble() * 100;
    setState(() {
      needleValue = randomValue;
    });
  }

  void validateAndRandomizePointer() {
    if (nameController.text.isNotEmpty) {
      randomizePointer();

      // Determine the range based on needleValue
      if (needleValue >= 0 && needleValue <= 33) {
        paymentOptions =
            'Debit/Credit Card \n EMI @ 7%   \n UPI  \n Netbanking';
      } else if (needleValue > 33 && needleValue <= 66) {
        paymentOptions =
            'Debit/Credit Card \n EMI @ 4%  \n UPI   \n Netbanking  \n Cash On Delivery';
      } else if (needleValue > 66 && needleValue <= 99) {
        paymentOptions =
            'Debit/Credit Card \n EMI @ 1%\n UPI   \n Netbanking \n Cash On Delivery';
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter a name before clicking the button.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SfRadialGauge(
              animationDuration: 1500.00,
              enableLoadingAnimation: true,
              axes: <RadialAxis>[
                RadialAxis(
                  showLabels: false,
                  showAxisLine: false,
                  showTicks: false,
                  minimum: 0,
                  maximum: 99,
                  ranges: <GaugeRange>[
                    GaugeRange(
                      startValue: 0,
                      endValue: 33,
                      color: Color(0xFFFE2A25),
                      label: 'Low',
                      sizeUnit: GaugeSizeUnit.factor,
                      labelStyle: GaugeTextStyle(fontFamily: 'Helvetica',fontSize: 20),
                      startWidth: 0.50,
                      endWidth: 0.50,
                    ),
                    GaugeRange(
                      startValue: 33,
                      endValue: 66,
                      color: Color(0xFFFFBA00),
                      label: 'Average',
                      labelStyle: GaugeTextStyle(fontSize: 20),
                      startWidth: 0.50,
                      endWidth: 0.50,
                      sizeUnit: GaugeSizeUnit.factor,
                    ),
                    GaugeRange(
                      startValue: 66,
                      endValue: 99,
                      color: Color(0xFF00AB47),
                      label: 'Best',
                      labelStyle: GaugeTextStyle(fontSize: 20),
                      sizeUnit: GaugeSizeUnit.factor,
                      startWidth: 0.50,
                      endWidth: 0.50,
                    ),
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(value: needleValue,
                    enableAnimation: true,
                      animationType: AnimationType.ease,
                      animationDuration: 1500,
                      needleLength: 0.60,),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Enter Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                validateAndRandomizePointer();
                setState(() {}); // Trigger a rebuild to update the UI
              },
              child: Text('Randomize Pointer'),
            ),
            SizedBox(height: 20),
            Text(
              'Available Payment Methods',

              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(paymentOptions,
            style: TextStyle(fontSize: 18),),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

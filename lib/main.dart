import 'package:flutter/material.dart';
import 'dart:math';
//import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  //const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // เอาป้าย dubug mode ออก
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final itemController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  final costController = TextEditingController();
  final itemController2 = TextEditingController();
  final qtyController2 = TextEditingController();
  final costController2 = TextEditingController();
  final itemController3 = TextEditingController();
  final qtyController3 = TextEditingController();
  final costController3 = TextEditingController();

  final FocusNode itemControllerFocusNode = FocusNode();

  String result = "Please input information";
  Color textColor = Colors.red;
  Color textBackColor = Colors.pink;

  double unitPrice = 0;
  double unitPrice2 = 0;
  double unitPrice3 = 0;
  double diffPercent = 0;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    itemController.dispose();
    qtyController.dispose();
    costController.dispose();
    itemController2.dispose();
    qtyController2.dispose();
    costController2.dispose();
    itemController3.dispose();
    qtyController3.dispose();
    costController3.dispose();
    super.dispose();
    //print("After Dispose");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //itemControllerFocusNode.requestFocus();
  }

  // Display Data
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Check Price"),
      ),
      body: Container(
          child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "$result",
            style: TextStyle(
                fontSize: 20,
                color: textColor,
                //backgroundColor: textBackColor,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  //onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      textStyle: TextStyle(
                          //fontSize: 30,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    unitPrice = 0;
                    unitPrice2 = 0;
                    unitPrice3 = 0;
                    diffPercent = 0;

                    if (costController.text != "") {
                      unitPrice = double.parse(costController.text) /
                          double.parse(qtyController.text);
                    }

                    if (costController2.text != "") {
                      unitPrice2 = double.parse(costController2.text) /
                          double.parse(qtyController2.text);
                    }

                    if (costController3.text != "") {
                      unitPrice3 = double.parse(costController3.text) /
                          double.parse(qtyController3.text);
                    }

                    print("UnitPrice = ${unitPrice}");
                    print("UnitPrice2 = ${unitPrice2.toDouble()}");
                    print("UnitPrice3 = ${unitPrice3.toDouble()}");

                    if (unitPrice3 == 0) {
                      if (unitPrice == unitPrice2) {
                        setState(() {
                          result = "You can choose Item A or Item B";
                          textColor = Colors.pink;
                        });
                      } else if (unitPrice < unitPrice2) {
                        diffPercent =
                            ((unitPrice2 - unitPrice) / unitPrice2) * 100;
                        //print(diffPercent.toString());
                        setState(() {
                          result = "Item A is cheaper than Item B " +
                              diffPercent.toStringAsFixed(2) +
                              "%";
                          textColor = Colors.blue;
                        });
                      } else if (unitPrice > unitPrice2) {
                        diffPercent =
                            ((unitPrice - unitPrice2) / unitPrice) * 100;
                        setState(() {
                          result = "Item B is cheaper than Item A " +
                              diffPercent.toStringAsFixed(2) +
                              "%";
                          textColor = Colors.green;
                        });
                      } else {
                        setState(() {
                          result = "Please input information";
                        });
                      }
                    } else {
                      if (unitPrice == unitPrice2) {
                        if (unitPrice == unitPrice3){
                          setState(() {
                            result = "You can choose Item A, B or C";
                            textColor = Colors.pink;
                          });
                        }else if(unitPrice>unitPrice3){
                          setState(() {
                              result = "Item C is the cheapest < A, B";
                              textColor = Colors.yellow;
                            });
                        }else {
                          setState(() {
                              result = "Item A, B is the cheapest < C";
                              textColor = Colors.blue;
                            });
                        }
                          
                      } else if (unitPrice < unitPrice2) {
                        if (unitPrice2 < unitPrice3) {
                          setState(() {
                            result = "Item A is the cheapest < B < C";
                            textColor = Colors.blue;
                          });
                        } else if (unitPrice2 > unitPrice3) {
                          if (unitPrice > unitPrice3) {
                            setState(() {
                              result = "Item C is the cheapest < A < B";
                              textColor = Colors.yellow;
                            });
                          } else if (unitPrice < unitPrice3){
                            setState(() {
                              result = "Item A is the cheapest < C < B";
                              textColor = Colors.blue;
                            });
                          } else {
                            setState(() {
                              result = "Item A,C is the cheapest < B";
                              textColor = Colors.yellow;
                            });
                          }
                        } else {
                          setState(() {
                              result = "Item A is the cheapest < B, C";
                              textColor = Colors.blue;
                            });
                        }
                        //diffPercent =
                        //((unitPrice2 - unitPrice) / unitPrice2) * 100;
                        //print(diffPercent.toString());
                        //setState(() {
                        //result = "Item A is cheaper than Item B " +
                        //diffPercent.toStringAsFixed(2) +
                        //"%";
                        //textColor = Colors.blue;
                        //});
                      } else if (unitPrice > unitPrice2) {
                        if(unitPrice2>unitPrice3){
                          if(unitPrice==unitPrice3){
                          setState(() {
                            result = "Item A, C is the cheapest < B ";
                            textColor = Colors.yellow;
                          });
                        }else {
                          setState(() {
                            result = "Item C is the cheapest < B < A";
                            textColor = Colors.yellow;
                          });
                        }
                          
                        }else if(unitPrice2<unitPrice3){
                          if(unitPrice==unitPrice3){
                            setState(() {
                            result = "Item B is the cheapest < A, C";
                            textColor = Colors.green;
                          });
                          }else {
                            setState(() {
                            result = "Item B is the cheapest < A < C";
                            textColor = Colors.green;
                          });
                          }
                          
                        }else {
                          setState(() {
                            result = "Item B,C is the cheapest < A";
                            textColor = Colors.green;
                          });
                        }

                        
                        
                      } else {
                        setState(() {
                          result = "Please input information";
                        });
                      }

                      //setState(() {
                      //result = "Item3 not 0";
                      //});
                    }
                  },
                  child: Text(
                    'Check',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  //onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      textStyle: TextStyle(
                          //fontSize: 30,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    itemController.clear();
                    qtyController.clear();
                    costController.clear();
                    itemController2.clear();
                    qtyController2.clear();
                    costController2.clear();
                    itemController3.clear();
                    qtyController3.clear();
                    costController3.clear();

                    unitPrice = 0;
                    unitPrice2 = 0;
                    unitPrice3 = 0;
                    diffPercent = 0;

                    setState(() {
                      result = "Please input information";
                      textColor = Colors.pink;
                    });

                    //When click clear button set focus as Item A
                    itemControllerFocusNode.requestFocus();
                  },
                  child: Text(
                    'Clear',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          MyCustomForm(
              itemController,
              qtyController,
              costController,
              itemController2,
              qtyController2,
              costController2,
              itemController3,
              qtyController3,
              costController3,
              itemControllerFocusNode),
        ],
      )),
      /*floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          /*showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the that user has entered by using the
                // TextEditingController.
                content: Text(itemController.text),
                
              );
            },
          );*/

          //print("Qty =  ${qtyController.text}");
          //print("Cost = ${costController.text}");
          //print("Qty2 =  ${qtyController2.text}");
          //print("Cost2 = ${costController2.text}");

          //print(double.parse(costController.text) ~/
          //double.parse(qtyController.text));
          if (costController.text != "") {
            unitPrice = double.parse(costController.text) /
                double.parse(qtyController.text);
          }

          if (costController2.text != "") {
            unitPrice2 = double.parse(costController2.text) /
                double.parse(qtyController2.text);
          }

          if (costController3.text != "") {
            unitPrice3 = double.parse(costController3.text) /
                double.parse(qtyController3.text);
          }

          //print("UnitPrice = ${unitPrice}");
          //print("UnitPrice2 = ${unitPrice2.toDouble()}");
          //print("UnitPrice3 = ${unitPrice3.toDouble()}");

          if (unitPrice == unitPrice2) {
            setState(() {
              result = "You can choose Item A or Item B";
              textColor = Colors.pink;
            });
          } else if (unitPrice < unitPrice2) {
            diffPercent = ((unitPrice2 - unitPrice) / unitPrice2) * 100;
            //print(diffPercent.toString());
            setState(() {
              result = "Item A is cheaper than Item B " +
                  diffPercent.toStringAsFixed(2) +
                  "%";
              textColor = Colors.blue;
            });
          } else if (unitPrice > unitPrice2) {
            diffPercent = ((unitPrice - unitPrice2) / unitPrice) * 100;
            setState(() {
              result = "Item B is cheaper than Item A " +
                  diffPercent.toStringAsFixed(2) +
                  "%";
              textColor = Colors.green;
            });
          } else {
            setState(() {
              result = "Please input information";
            });
          }
        },
        tooltip: 'Show me the value!',
        child: const Icon(Icons.check),
      ),*/
    );
  }
}

class MyCustomForm extends StatelessWidget {
  //const MyCustomForm({key});

  TextEditingController? itemController;
  TextEditingController? qtyController;
  TextEditingController? costController;
  TextEditingController? itemController2;
  TextEditingController? qtyController2;
  TextEditingController? costController2;
  TextEditingController? itemController3;
  TextEditingController? qtyController3;
  TextEditingController? costController3;

  FocusNode itemControllerFocusNode;

  MyCustomForm(
      this.itemController,
      this.qtyController,
      this.costController,
      this.itemController2,
      this.qtyController2,
      this.costController2,
      this.itemController3,
      this.qtyController3,
      this.costController3,
      this.itemControllerFocusNode);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            controller: itemController,
            focusNode: itemControllerFocusNode,
            autofocus: true,
            cursorColor: Colors.blue,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Item A',
              fillColor: Colors.lightBlue,
              filled: true,
            ),
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              /*Expanded(
                child: TextField(
                  controller: qtyController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Qty',
                    fillColor: Colors.lightBlue,
                    filled: true,
                  ),
                ),
              ),
              SizedBox(width: 50),
              Expanded(
                child: TextField(
                  controller: costController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Cost',
                    fillColor: Colors.lightBlue,
                    filled: true,
                  ),
                ),
              ),*/
              Expanded(
                child: TextFormField(
                  controller: qtyController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter Qty',
                    fillColor: Colors.lightBlue,
                    filled: true,
                  ),
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                ),
              ),
              SizedBox(width: 50),
              Expanded(
                child: TextFormField(
                  controller: costController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter Cost',
                    fillColor: Colors.lightBlue,
                    filled: true,
                  ),
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                ),
              )
            ],
          ),
          /*TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
            ),
          ),*/
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            controller: itemController2,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Item B',
              fillColor: Colors.lightGreen,
              filled: true,
            ),
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              /*Expanded(
                child: TextField(
                  controller: qtyController2,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Qty',
                    fillColor: Colors.lightGreen,
                    filled: true,
                  ),
                ),
              ),
              SizedBox(width: 50),
              Expanded(
                child: TextField(
                  controller: costController2,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Cost',
                    fillColor: Colors.lightGreen,
                    filled: true,
                  ),
                ),
              ),
              SizedBox(width: 50),*/
              Expanded(
                child: TextFormField(
                  controller: qtyController2,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter Qty',
                    fillColor: Colors.lightGreen,
                    filled: true,
                  ),
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                ),
              ),
              SizedBox(width: 50),
              Expanded(
                child: TextFormField(
                  controller: costController2,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter Cost',
                    fillColor: Colors.lightGreen,
                    filled: true,
                  ),
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                ),
              )
            ],
          ),
          /*TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
            ),
          ),*/
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            controller: itemController3,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Item C',
              fillColor: Colors.yellow,
              filled: true,
            ),
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              /*Expanded(
                child: TextField(
                  controller: qtyController2,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Qty',
                    fillColor: Colors.lightGreen,
                    filled: true,
                  ),
                ),
              ),
              SizedBox(width: 50),
              Expanded(
                child: TextField(
                  controller: costController2,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Cost',
                    fillColor: Colors.lightGreen,
                    filled: true,
                  ),
                ),
              ),
              SizedBox(width: 50),*/
              Expanded(
                child: TextFormField(
                  controller: qtyController3,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter Qty',
                    fillColor: Colors.yellow,
                    filled: true,
                  ),
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                ),
              ),
              SizedBox(width: 50),
              Expanded(
                child: TextFormField(
                  controller: costController3,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter Cost',
                    fillColor: Colors.yellow,
                    filled: true,
                  ),
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                ),
              )
            ],
          ),
          /*TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
            ),
          ),*/
        ),
      ],
    );
    //print(_MyHomePageState().qtyController.text);
    //print(_MyHomePageState().costController.text);
  }
}

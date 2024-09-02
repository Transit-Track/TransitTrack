
import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

class Test2 extends StatefulWidget {
  const Test2({super.key});

  @override
  State<Test2> createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  Future<dynamic> startTransaction(double amount, String phoneNumber) async {
    dynamic transactionInitialisation;

    try {
      transactionInitialisation =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
        businessShortCode: "174379",
        transactionType: TransactionType.CustomerPayBillOnline,
        amount: amount,
        partyA: phoneNumber,
        partyB: "174379",
        callBackURL:
            Uri(scheme: "https", host: "1234.1234.co.ke", path: "/1234.php"),
        accountReference: "Buy bus ticket",
        phoneNumber: phoneNumber,
        baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
        transactionDesc: "purchase",
        passKey:
            "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919",
      );

      print(
          "ressssssssssssssult: ---->>>> ${transactionInitialisation.toString()}");
    } catch (e) {
      print(e.toString());
    }
  }

  List<Map<String, dynamic>> itemsOnSale = [
    {
      "image": "image/shoe.jpg",
      "itemName": "Breathable Oxford Casual Shoes",
      "price": 1.0
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Page'),
      ),
      // body:  Center(
      // child: ElevatedButton(
      // child: const Text('Payment Page'),
      //  onPressed: () {
      //    startTransaction(10.0, '254712345678');
      // },
      //),
      // ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 4.0,
            child: Container(
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.brown),
              height: MediaQuery.of(context).size.height * 0.35,
              //color: Colors.brown,
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Image.asset(
                      itemsOnSale[index]["image"],
                      fit: BoxFit.cover,
                    ),
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.95,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Text(
                          itemsOnSale[index]["itemName"],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14.0, color: Colors.black),
                        ),
                      ),
                      Text(
                        "Ksh. " + itemsOnSale[index]["price"].toString(),
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                          ),
                          onPressed: () async {
                            var providedContact =
                                await _showTextInputDialog(context);

                            if (providedContact != null) {
                              if (providedContact.isNotEmpty) {
                                startTransaction(
                                  itemsOnSale[index]["price"],
                                  "+251707602038",
                                );
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Empty Number!'),
                                        content: Text(
                                            "You did not provide a number to be charged."),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            child: const Text("Cancel"),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ],
                                      );
                                    });
                              }
                            }
                          },
                          child: Text("Checkout"))
                    ],
                  )
                ],
              ),
            ),
          );
        },
        itemCount: itemsOnSale.length,
      ),
    );
  }

  final _textFieldController = TextEditingController();

  Future<String?> _showTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('M-Pesa Number'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: "+254..."),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                child: const Text('Proceed'),
                onPressed: () =>
                    Navigator.pop(context, _textFieldController.text),
              ),
            ],
          );
        });
  }
}

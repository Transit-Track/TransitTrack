// For base64 decoding
// For Uint8List

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transittrack/core/theme.dart';
import 'package:transittrack/features/home/domain/entities/bus_entity.dart';
import 'package:transittrack/features/tickets/domain/entites/ticket_entity.dart';
import 'package:transittrack/features/tickets/domain/usecases/initiate_payment_usecase.dart';
import 'package:transittrack/features/tickets/domain/usecases/handle_callback_usecase.dart'; // Added callback usecase
import 'package:transittrack/features/tickets/presentation/widget/payment_method_card_widget.dart';
import 'package:transittrack/features/tickets/presentation/widget/pin_dialog.dart';
import 'package:transittrack/features/tickets/presentation/widget/success_dialog.dart';

class PaymentPage extends StatefulWidget {
  final Ticket ticket;
  final InitiatePaymentUsecase initiatePaymentUsecase;
  final HandleCallbackUseCase handleCallbackUsecase;

  const PaymentPage({
    super.key,
    required this.ticket,
    required this.initiatePaymentUsecase,
    required this.handleCallbackUsecase, required BusEntity bus,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _ticketAmountController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  String? _qrCodeUrl; // To store QR code URL

  Future<void> initiatePayment(double amount, int numOfTickets) async {
    try {
      // Simulate payment initiation
      final result = await widget.initiatePaymentUsecase(
        InitiatePaymentParams(
          userId: "12345", // Replace with actual user ID
          amount: amount,
          numberOfTickets: numOfTickets,
          startLocation: widget.ticket.start,
          destination: widget.ticket.destination,
          busId: widget.ticket.busId,
        ),
      );

      // After initiating the payment, ask for PIN
      showPinDialog();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  void showPinDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PinDialog(
          pinController: _pinController,
          onConfirm: () async {
            Navigator.of(context).pop(); // Close the dialog
            // Handle the PIN confirmation here
            await _handlePaymentCallback(); // Proceed with handling payment callback
          },
        );
      },
    );
  }

  Future<void> _handlePaymentCallback() async {
    try {
      // Prepare callback data to match the expected structure
      Map<String, dynamic> callbackData = {
        "Body": {
          "stkCallback": {
            "CheckoutRequestID": "64f20e4a47b5f75c21b69eb3", // A valid ObjectId
            "ResultCode": 0,
            "CallbackMetadata": {
              "Item": [
                {"Name": "Amount", "Value": 100},
                {"Name": "MpesaReceiptNumber", "Value": "ABC123XYZ"},
                {"Name": "TransactionDate", "Value": 20230920123045},
                {"Name": "PhoneNumber", "Value": "254700123456"}
              ]
            }
          }
        }
      };

      // Call the use case
      final result = await widget.handleCallbackUsecase(callbackData);
      result.fold(
        (failure) {
          // Handle failure
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Callback error: $failure')),
          );
        },
        (qrCodeBase64) {
          // On success, show the QR code
          setState(() {
            _qrCodeUrl = qrCodeBase64;
          });
          showSuccessDialog(); // Show the success dialog with the QR code
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unexpected error: ${e.toString()}')),
      );
    }
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SuccessDialog(
          qrCodeBase64: _qrCodeUrl, // Pass the base64 QR code string
        );
      },
    );
  }

  List<String> paymentMethodImagePaths = [
    'assets/images/safaricom.png',
    'assets/images/tele_birr.png',
    'assets/images/cbe_birr.png'
  ];

  List<Color> colors = [
    const Color.fromARGB(255, 217, 252, 223),
    const Color.fromARGB(255, 217, 235, 255),
    const Color.fromARGB(255, 238, 212, 255),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        backgroundColor: Colors.white,
        onPressed: () => Navigator.of(context).pop(),
        child: const Icon(Icons.arrow_back),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: primary,
            ),
            child: Column(
              children: [
                SizedBox(height: 50.h),
                Center(
                  child: Text(
                    'Payment',
                    style: TextStyle(
                      color: white,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                Row(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/anbessa.png',
                          width: 100.w,
                          height: 80.h,
                        ),
                        Text('Anbessa Bus',
                            style: TextStyle(fontSize: 10.sp, color: white)),
                      ],
                    ),
                    SizedBox(width: 10.w),
                    Padding(
                      padding: EdgeInsets.only(top: 12.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.67,
                            child: Text(
                              'From ${widget.ticket.start} to ${widget.ticket.destination}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: white,
                              ),
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          SizedBox(height: 15.h),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.67,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Bus Number: ${widget.ticket.busId}',
                                  style:
                                      TextStyle(fontSize: 16.sp, color: white),
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/time.png',
                                      width: 30.w,
                                      height: 30.h,
                                      color: white,
                                    ),
                                    Text(
                                      '${widget.ticket.arrivalTime} min',
                                      style: TextStyle(
                                          fontSize: 16.sp, color: white),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Text(
                            '${widget.ticket.price} ETB',
                            style: TextStyle(fontSize: 16.sp, color: white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30.h),
                    Text(
                      'Pay By',
                      style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                          color: secondary),
                    ),
                    SizedBox(height: 30.h),
                    Column(
                      children: [
                        Text(
                          'Enter number of tickets',
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: TextFormField(
                            controller: _ticketAmountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Number of tickets',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 300.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(8.h),
                            child: PaymentMethodCardWidget(
                              color: colors[index],
                              imagePath: paymentMethodImagePaths[index],
                              onPressed: () {
                                if (_ticketAmountController.text.isNotEmpty) {
                                  int numOfTickets =
                                      int.parse(_ticketAmountController.text);
                                  double totalAmount =
                                      widget.ticket.price * numOfTickets;
                                  initiatePayment(totalAmount, numOfTickets);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Please enter the number of tickets')),
                                  );
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

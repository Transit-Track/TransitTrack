import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transittrack/core/theme.dart';
import 'package:transittrack/features/tickets/domain/entites/ticket_entity.dart';
import 'package:transittrack/features/tickets/domain/usecases/initiate_payment_usecase.dart';
import 'package:transittrack/features/tickets/presentation/widget/payment_method_card_widget.dart';

class PaymentPage extends StatefulWidget {
  final Ticket ticket;
  final InitiatePaymentUsecase initiatePaymentUsecase;

  const PaymentPage({
    Key? key,
    required this.ticket,
    required this.initiatePaymentUsecase,
  }) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _ticketAmountController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  Future<void> initiatePayment(double amount, int numOfTickets) async {
    try {
      // Simulate payment initiation
      final result = await widget.initiatePaymentUsecase(
        InitiatePaymentParams(
          userId: "12345",  // Replace with actual user ID
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
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: const Text("Enter PIN"),
          content: TextFormField(
            controller: _pinController,
            keyboardType: TextInputType.number,
            obscureText: true,
            maxLength: 4,
            decoration: const InputDecoration(
              hintText: 'Enter your 4-digit PIN',
              border: OutlineInputBorder(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Confirm"),
              onPressed: () {
                if (_pinController.text == "1234") { // Assume PIN is '1234' for now
                  Navigator.of(context).pop();  // Close the PIN dialog
                  showSuccessDialog();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Incorrect PIN')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: const Text("Payment Successful"),
          content: const Text("Your payment has been successfully processed."),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();  // Close the success dialog
              },
            ),
          ],
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
                                  style: TextStyle(
                                      fontSize: 16.sp, color: white),
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
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:transittrack/core/routes/route_path.dart';
import 'package:transittrack/core/theme.dart';
import 'package:transittrack/features/home/domain/entities/bus.dart';
import 'package:transittrack/features/tickets/presentation/widget/payment_method_card_widget.dart';

class PaymentPage extends StatefulWidget {
  final Bus bus;

  const PaymentPage({super.key, required this.bus});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Future<dynamic> startTransaction(double amount, String phoneNumber) async {
    dynamic transactionInitialisation;

    try {
      transactionInitialisation = await MpesaFlutterPlugin.initializeMpesaSTKPush(
        businessShortCode: "174379",
        transactionType: TransactionType.CustomerPayBillOnline,
        amount: amount,
        partyA: phoneNumber,
        partyB: "174379",
        callBackURL: Uri(scheme: "https", host: "1234.1234.co.ke", path: "/1234.php"),
        accountReference: "Buy bus ticket",
        phoneNumber: phoneNumber,
        baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
        transactionDesc: "purchase",
        passKey: "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919",
      );

      print("Transaction result: ${transactionInitialisation.toString()}");
    } catch (e) {
      print("Error: $e");
    }
  }

  List<String> paymentMethodImagePaths = [
    'assets/images/safaricom.png',
    'assets/images/tele_birr.png',
    'assets/images/cbe_birr.png'
  ];

  List<Color> colors = [
    Color.fromARGB(255, 217, 252, 223),
    Color.fromARGB(255, 217, 235, 255),
    Color.fromARGB(255, 238, 212, 255),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        leading:  FloatingActionButton(
          shape: ShapeBorder.lerp(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              0.5),
          backgroundColor: Colors.white,
          onPressed: () => {(context).goNamed(AppPath.realTimeVehicleTracking)},
          child: const Icon(Icons.arrow_back),
        ),
        
      ),
      body: Column(
        children: [
          // Blue Container for Payment Information and Bus Information
          Container(
            padding: EdgeInsets.all(16.w),
            color: primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Payment Information Text
                Center(
                  child: Text(
                    'Payment Information',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 50.h), // Space between Payment Info and Bus Info

                // Bus Information Section
                Row(
                  children: [
                    Image.asset(
                      'assets/images/anbessa.png',
                      width: 80.w,
                      height: 60.h,
                    ),
                    SizedBox(width: 16.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mexico --> Shiro Meda',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Text(
                              '01',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 100.w),
                            Row(
                              children: [
                                Icon(Icons.access_time, color: Colors.white, size: 16.sp),
                                SizedBox(width: 4.w),
                                Text(
                                  '45 min',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '10 stops',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 32.h), // Space between Bus Info and Payment Info
              ],
            ),
          ),

          // Payment Methods Section
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 150.h),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: paymentMethodImagePaths.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: PaymentMethodCardWidget(
                      color: colors[index],
                      imagePath: paymentMethodImagePaths[index],
                      onPressed: () {
                        if (index == 0) {
                          startTransaction(10.0, '254712345678');
                        } else {
                          // Handle other payment methods
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

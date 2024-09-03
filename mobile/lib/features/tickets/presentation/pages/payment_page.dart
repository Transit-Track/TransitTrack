import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:transittrack/core/routes/route_path.dart';
import 'package:transittrack/core/theme.dart';
import 'package:transittrack/features/home/domain/entities/bus.dart';
import 'package:transittrack/features/tickets/presentation/widget/payment_method_card_widget.dart';

class PaymentPage extends StatefulWidget {
  final BusEntity bus;

  const PaymentPage({super.key, required this.bus});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
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
      floatingActionButton: FloatingActionButton(
        shape: ShapeBorder.lerp(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            0.5),
        backgroundColor: Colors.white,
        onPressed: () => {(context).pop()},
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
                 SizedBox(
                            height: 50.h,
                          ),
                Center(
                  child: Text(
                    'Paymnet',
                    style: TextStyle(
                        color: white,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                 SizedBox(
                            height: 50.h,
                          ),
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
                              'From ${widget.bus.start} to ${widget.bus.destination}',
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
                                  'Bus Number: ${widget.bus.number}',
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
                                      '${widget.bus.arrivalTime} min',
                                      style: TextStyle(
                                          fontSize: 16.sp, color: white),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Text(
                            '${widget.bus.price}ETB',
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
                                  index == 0
                                      ? startTransaction(10.0, '254712345678')
                                      : null;
                                }),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

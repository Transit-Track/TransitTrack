import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transittrack/core/theme.dart';
import 'package:transittrack/core/widgets/custom_appbar_widget.dart';
import 'package:transittrack/features/tickets/domain/entites/ticket_entity.dart';
import 'package:transittrack/features/tickets/presentation/pages/QR_page.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();

  // Example list of tickets
  final List<Ticket> tickets = [
    Ticket(
      ticketId: '1',
      userId: 'user_1',
      busId: 'bus_1',
      issueDate: DateTime.now(),
      start: 'Mexico',
      destination: 'Shiro Meda',
      price: 30.0,
      expiryDate: DateTime.now().add(Duration(hours: 24)),
      status: 'active',
    ),
    Ticket(
      ticketId: '2',
      userId: 'user_2',
      busId: 'bus_2',
      issueDate: DateTime.now(),
      start: 'Mexico',
      destination: 'Shiro Meda',
      price: 50.0,
      expiryDate: DateTime.now().add(Duration(hours: 24)),
      status: 'active',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: CustomAppBarWidget(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Adding the input section for "from" and "to"
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text('from '),
                          Icon(Icons.circle, color: primary, size: 12.sp),
                        ],
                      ),
                      SizedBox(
                        width: 2.w,
                        height: 40.h,
                      ),
                      Row(
                        children: [
                          Text('to     '),
                          Icon(Icons.circle, color: Colors.red, size: 12.sp),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _fromController,
                          decoration: InputDecoration(
                            hintText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        TextFormField(
                          controller: _toController,
                          decoration: InputDecoration(
                            hintText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                  height:
                      20.h), // Spacing between the input section and tickets
              Text(
                "Your Tickets",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              // The ticket list area
              Expanded(
                child: ListView.builder(
                  itemCount: tickets.length,
                  itemBuilder: (context, index) {
                    final ticket = tickets[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => QRCodePage(),
                            ),
                          );
                        },
                        child: Card(
                          color: white,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Ticket route details
                                Text(
                                  "From ${ticket.start} To ${ticket.destination}",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                // Stops and time row

                                SizedBox(height: 8.sp),
                                // Ticket price and amount spent
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Money Spent: ${ticket.price.toString()}",
                                          style: TextStyle(fontSize: 16.sp),
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                                'assets/images/time.png',
                                                width: 30.w,
                                                height: 30.w),
                                            Text(
                                              "45 min",
                                              style: TextStyle(fontSize: 16.sp),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Amount: 3",
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                // Ticket deadline
                                Text(
                                  "Deadline: 24hrs",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

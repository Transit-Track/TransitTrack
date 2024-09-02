import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transittrack/core/theme.dart';
import 'package:transittrack/core/widgets/custom_appbar_widget.dart';
import 'package:transittrack/core/widgets/custom_navbar_widget.dart';
import 'package:transittrack/core/widgets/button_widget.dart';
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
      expiryDate: DateTime.now().add(const Duration(hours: 24)),
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
      expiryDate: DateTime.now().add(const Duration(hours: 24)),
      status: 'active',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: const CustomAppBarWidget(),
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
                      const Row(
                        children: [
                          Text('from '),
                          Icon(Icons.circle, color: primary, size: 12),
                        ],
                      ),
                      Container(
                        width: 0,
                        height: 40,
                        color: Colors.grey,
                      ),
                      const Row(
                        children: [
                          Text('to     '),
                          Icon(Icons.circle, color: Colors.red, size: 12),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
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
                        const SizedBox(height: 10),
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
              const SizedBox(
                  height: 20), // Spacing between the input section and tickets
              const Text(
                "Your Tickets",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // The ticket list area
              Expanded(
                child: ListView.builder(
                  itemCount: tickets.length,
                  itemBuilder: (context, index) {
                    final ticket = tickets[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Card(
                        color: white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
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
                             SizedBox(height: 10.h),
                              // Stops and time row
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "10 Stops",
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/time.png',
                                        width: 20.w,
                                        height: 20.h,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "45 min",
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              // Ticket price and amount spent
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Money Spent: ${ticket.price.toString()}",
                                    style:  TextStyle(fontSize: 14.sp),
                                  ),
                                   Text(
                                    "Amount: 3",
                                    style: TextStyle(fontSize: 14.sp),
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
                              //  SizedBox(height: 16.h),
                              // Admit button
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Center(
                                    child: ButtonWidget(
                                      width: 100.h,
                                      height: 40.w,
                                      text: 'Admit',
                                      onClick: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              backgroundColor: white,
                                              insetAnimationCurve:
                                                  Curves.easeIn,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const Text(
                                                      "Are you sure you want to use this ticket?",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        // Yes Button
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // Close the dialog
                                                            Navigator.of(
                                                                    context)
                                                                .push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const QRCodePage()),
                                                            );
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors.blue,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        24,
                                                                    vertical:
                                                                        12),
                                                          ),
                                                          child: const Text(
                                                            "Yes",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 20),
                                                        // No Button
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // Close the dialog
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors.red,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        24,
                                                                    vertical:
                                                                        12),
                                                          ),
                                                          child: const Text(
                                                            "No",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      context: context,
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
        bottomNavigationBar: const CustomNavbarWidget(),
      ),
    );
  }
}

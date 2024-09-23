import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transittrack/core/theme.dart';
import 'package:transittrack/features/home/domain/entities/bus_entity.dart';
import 'package:transittrack/features/my_route/presentation/bloc/my_route_bloc.dart';

class CardWidget extends StatefulWidget {
  final BusEntity bus;

  const CardWidget({super.key, required this.bus});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool isMyRoute = false;

  @override
  void initState() {
    isMyRoute = widget.bus.isMyRoute;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: white,
      height: 130.h,
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Padding(
        padding: EdgeInsets.fromLTRB(5.0.w, 6.0.h, 5.0.w, 6.h),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Image.asset(
                    widget.bus.type == 'anbessa'
                        ? 'assets/images/anbessa.png'
                        : 'assets/images/sheger.png',
                    width: 50.w,
                    height: 50.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                'Anbessa Bus',
                style: TextStyle(fontSize: 10.sp),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.bus.route.stations[0].name} to ${widget.bus.route.stations[widget.bus.route.stations.length - 1].name}',
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 18.w,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.bus.number,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isMyRoute = !isMyRoute;
                              if (isMyRoute) {
                                context.read<MyRouteBloc>().add(
                                      AddBusToMyRouteEvent(
                                        busId: widget.bus.number,
                                      ),
                                    );
                                context.read<MyRouteBloc>().add(
                                      GetMyRouteEvent(),
                                    );
                              } else {
                                context.read<MyRouteBloc>().add(
                                    RemoveBusToMyRouteEvent(
                                        busId: widget.bus.number));
                                context.read<MyRouteBloc>().add(
                                      GetMyRouteEvent(),
                                    );
                              }
                            });
                          },
                          child: isMyRoute
                              ? const Icon(
                                  Icons.favorite,
                                  color: primary,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  color: const Color.fromARGB(255, 54, 54, 54)
                                      .withOpacity(0.5),
                                ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.bus.route.distance} meters',
                    style: const TextStyle(),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Price: ${widget.bus.route.stations.length}ETB',
                      style: const TextStyle(),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "See Route",
                            style: TextStyle(color: primary),
                          ),
                          Container(
                              height: 30.h,
                              width: 30.w,
                              decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Icon(
                                Icons.directions,
                                color: Colors.white,
                                size: 30.sp,
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

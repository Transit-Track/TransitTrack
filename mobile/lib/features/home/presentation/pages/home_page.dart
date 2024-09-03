import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:transittrack/core/routes/route_path.dart';
import 'package:transittrack/core/theme.dart';
import 'package:transittrack/core/utils/validation.dart';
import 'package:transittrack/core/widgets/button_widget.dart';
import 'package:transittrack/core/widgets/custom_appbar_widget.dart';
import 'package:transittrack/features/home/presentation/bloc/home_bloc.dart';
import 'package:transittrack/features/home/presentation/pages/dummy_data.dart';
import 'package:transittrack/features/home/presentation/widgets/card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String token = "1234567546";
  bool startPressed = false;
  bool destinationPressed = false;

  void searchNearbyBusesForStart(String input) async {
    context
        .read<HomeBloc>()
        .add(GetNearbyBusesForStartEvent(input: input));
  }

  void searchNearbyBusesForDestination(String input) async {
    context
        .read<HomeBloc>()
        .add(GetNearbyBusesForDestinationEvent(input: input));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _startController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is LocationErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is NearByBusesForStartErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is NearByBusesForStartLoadedState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("success")));
        } else if (state is LocationLoadedState) {
          startPressed = true;
        } else if (state is NearByBusesForStartLoadedState) {
          destinationPressed = true;
        } else if (state is AvailableBusesErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        } else if (state is AvailableBusesLoadedState) {
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(SnackBar(content: Text("loaded....")));
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: white,
          appBar: const CustomAppBarWidget(),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height.h,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _startController,
                        decoration: InputDecoration(
                            labelText: 'Start',
                            hintText: 'Enter start location',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            prefixIcon: const Icon(
                              Icons.location_on,
                              color: secondary,
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.search, color: primary),
                              onPressed: () {
                                setState(() {
                                  startPressed = true;
                                  searchNearbyBusesForStart(_startController.text);
                                });
                              },
                            )),
                        validator: canNotBeNull,
                      ),
                      BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          if (state is NearByBusesForStartLoadingState) {
                            return Padding(padding: EdgeInsets.only(top: 20.h),
                                child: const Center(child:  CircularProgressIndicator()));
                          } else if (state is NearByBusesForStartLoadedState) {
                            if (state.nearByBusesForStartList.isEmpty) {
                              return const SizedBox(
                                height: 0,
                              );
                            }
                            return Visibility(
                              visible: startPressed,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.nearByBusesForStartList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          _startController.text =
                                              state.nearByBusesForStartList[index];
                                          startPressed = false;
                                        });
                                        // List<Location> locations =
                                        //     await locationFromAddress(
                                        //         state.locationList[index].name);
                                        // print(
                                        //     "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee${locations}");
                                        // print(
                                        //     "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee${locations[0].latitude}");
                                        // print(
                                        //     "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee${locations[0].longitude}");
                                      },
                                      child: ListTile(
                                        title:
                                            Text(state.nearByBusesForStartList[index]),
                                      ));
                                },
                              ),
                            );
                          } else if (state is LocationErrorState) {
                            return const SizedBox(
                              height: 0,
                            );
                          }
                          return const SizedBox(
                            height: 0,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _destinationController,
                        decoration: InputDecoration(
                            labelText: 'Destination',
                            prefixIcon: const Icon(
                              Icons.location_on,
                              color: secondary,
                            ),
                            hintText: 'Enter your destination',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.search, color: danger),
                              onPressed: () {
                                setState(() {
                                  destinationPressed = true;
                                  searchNearbyBusesForDestination(_destinationController.text);
                                });
                              },
                            )),
                        validator: canNotBeNull,
                      ),
                      BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                        if (state is NearByBusesForDestinationLoadingState) {
                          return const SizedBox(height: 0);
                        } else if (state is NearByBusesForDestinationErrorState) {
                          return const SizedBox(height: 0);
                        } else if (state is NearByBusesForDestinationLoadedState) {
                          return Visibility(
                            visible: destinationPressed,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.nearByBusesForDestinationList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      destinationPressed = false;
                                      _destinationController.text =
                                          state.nearByBusesForDestinationList[index];
                                    },
                                    child: ListTile(
                                      title: Text(state.nearByBusesForDestinationList[index]),
                                    ));
                              },
                            ),
                          );
                        }
                        return const SizedBox(height: 0);
                      }),
                      const SizedBox(height: 30),
                      Center(
                        child: BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state is AvailableBusesLoadingState) {
                              return const CircularProgressIndicator();
                            }
                            return ButtonWidget(
                                context: context,
                                text: 'Search',
                                onClick: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<HomeBloc>().add(
                                          GetAvailableBusesEvent(
                                            // startStation: "Station A",
                                            startStation: _startController.text,
                                            destinationStation:
                                                _destinationController.text,
                                            //  destinationStation:
                                            // "Station B",
                                          ),
                                        );
                                  }
                                });
                          },
                        ),
                      ),
                      SizedBox(height: 36.h),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text('Available Buses',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      SizedBox(height: 6.h),
                      BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          if (State is AvailableBusesLoadingState) {
                            return const CircularProgressIndicator(
                              color: primary,
                            );
                          } else if (state is AvailableBusesErrorState) {
                            return Center(child: Text(state.errorMessage));
                          } else if (state is AvailableBusesLoadedState) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: ListView.builder(
                                itemCount: buses.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(top: 15.h),
                                    child: InkWell(
                                      onTap: () {
                                        (context).goNamed(
                                            AppPath.realTimeVehicleTracking,
                                            extra: {
                                              "bus": buses[index],
                                            });
                                      },
                                      child: CardWidget(bus: buses[index]),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                          return const SizedBox(
                            height: 0.0,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

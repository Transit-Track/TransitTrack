import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:transittrack/core/routes/route_path.dart';
import 'package:transittrack/core/theme.dart';
import 'package:transittrack/core/widgets/button_widget.dart';
import 'package:transittrack/core/widgets/custom_appbar_widget.dart';
import 'package:transittrack/core/widgets/custom_navbar_widget.dart';
import 'package:transittrack/features/home/presentation/bloc/home_bloc.dart';
import 'package:geocoding/geocoding.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final String token = "1234567546";
  bool startPressed = false;
  bool destinationPressed = false;

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

  void searchNearbyBuses(
      String input, double longitude, double latitude, double radius) async {
    context.read<HomeBloc>().add(GetNearbyBusesEvent(
        input: input,
        longitude: longitude,
        latitude: latitude,
        radius: radius));
  }

  void palceSuggestion(String input) async {
    context.read<HomeBloc>().add(GetLocationEvent(input: input));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is LocationErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is NearByBusesErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is LocationLoadedState) {
          startPressed = true;
        } else if (state is NearByBusesLoadedState) {
          destinationPressed = true;
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
                          prefixIcon: Icon(
                            Icons.location_on,
                            color: secondary,
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              setState(() {
                                palceSuggestion(_startController.text);
                              });
                            },
                          )),
                    ),
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if (state is LocationLoadingState) {
                          return const SizedBox(
                            height: 0,
                          );
                        } else if (state is LocationLoadedState) {
                          if (state.locationList.isEmpty) {
                            return const SizedBox(
                              height: 0,
                            );
                          }
                          return Visibility(
                            visible: startPressed,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.locationList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        _startController.text =
                                            state.locationList[index].name;
                                        startPressed = false;
                                      });

                                      List<Location> locations =
                                          await locationFromAddress(
                                              state.locationList[index].name);
                                      // print(
                                      //     "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee${locations}");
                                      // print(
                                      //     "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee${locations[0].latitude}");
                                      // print(
                                      //     "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee${locations[0].longitude}");
                                    },
                                    child: ListTile(
                                      title:
                                          Text(state.locationList[index].name),
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
                          prefixIcon: Icon(
                            Icons.location_on,
                            color: secondary,
                          ),
                          hintText: 'Enter your destination',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              setState(() {
                                destinationPressed = true;
                                searchNearbyBuses(_destinationController.text,
                                    9.0205, 38.7468, 500.0);
                              });
                            },
                          )),
                    ),
                    BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                      if (state is NearByBusesLoadingState) {
                        return const SizedBox(height: 0);
                      } else if (state is NearByBusesErrorState) {
                        return const SizedBox(height: 0);
                      } else if (state is NearByBusesLoadedState) {
                        return Visibility(
                          visible: destinationPressed,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.nearByBusesList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      destinationPressed = false;
                                      _destinationController.text =
                                          state.nearByBusesList[index].name;
                                    });
                                  },
                                  child: ListTile(
                                    title: Text(
                                        state.nearByBusesList[index].name!),
                                  ));
                            },
                          ),
                        );
                      }
                      return const SizedBox(height: 0);
                    }),
                    const SizedBox(height: 30),
                    Center(
                      child: ButtonWidget(
                          context: context,
                          text: 'Search',
                          onClick: () {
                            (context)
                                .goNamed(AppPath.realTimeVehicleTrackingPage);
                          }),
                    ),
                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text('Nearby Station Stops',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          // Wrap(children: ListView.builder(itemBuilder: itemBuilder),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: CustomNavbarWidget(),
        ),
      ),
    );
  }
}

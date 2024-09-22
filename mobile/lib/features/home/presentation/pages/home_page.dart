import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:go_router/go_router.dart';
import 'package:transittrack/core/routes/route_path.dart';
import 'package:transittrack/core/theme.dart';
import 'package:transittrack/core/utils/validation.dart';
import 'package:transittrack/core/widgets/button_widget.dart';
import 'package:transittrack/core/widgets/custom_appbar_widget.dart';
import 'package:transittrack/features/home/presentation/bloc/home_bloc.dart';
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

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetStationNames());
  }

  final List<String> stations = [
    'Arada',
    '4 kilo',
    'Piyasa',
    'Megenagna',
    '5 kilo',
    '6 kilo',
    'CMC',
    'Ayat',
    'Mexico',
  ];

  static List<String> getSuggestions(String query, List<String> stationNames) {
    List<String> matches = [];
    matches.addAll(stationNames);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
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
        if (state is AvailableBusesErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: white,
          appBar: const CustomAppBarWidget(),
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is GetStationNamesLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetStationNamesLoadedState) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height.h,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TypeAheadField(
                              controller: _startController,
                              hideOnEmpty: true,
                              hideOnLoading: true,
                              hideOnUnfocus: true,
                              itemBuilder: (context, state) {
                                return ListTile(
                                  tileColor: white,
                                  title: Text(state.toString()),
                                );
                              },
                              onSelected: (val) {
                                _startController.text = val;
                              },
                              suggestionsCallback: (search) =>
                                  getSuggestions(search, state.stationNames),
                              builder: (context, controller, focusNode) {
                                return TextFormField(
                                  controller: _startController,
                                  focusNode: focusNode,
                                  decoration: InputDecoration(
                                    labelText: 'Start',
                                    hintText: 'Enter start location',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    prefixIcon: const Icon(
                                      Icons.location_on,
                                      color: secondary,
                                    ),
                                  ),
                                  validator: canNotBeNull,
                                );
                              },
                            ),
                            SizedBox(height: 20.h),

                            TypeAheadField(
                              controller: _destinationController,
                              itemBuilder: (context, state) {
                                return ListTile(
                                  tileColor: white,
                                  title: Text(state.toString()),
                                );
                              },
                              onSelected: (val) {
                                _destinationController.text = val.toString();
                              },
                              suggestionsCallback: (search) =>
                                  getSuggestions(search, state.stationNames),
                              builder: (context, controller, focusNode) {
                                return TextFormField(
                                  controller: _destinationController,
                                  focusNode: focusNode,
                                  decoration: InputDecoration(
                                    labelText: 'Destination',
                                    hintText: 'Enter destination location',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    prefixIcon: const Icon(
                                      Icons.location_on,
                                      color: secondary,
                                    ),
                                  ),
                                  validator: canNotBeNull,
                                );
                              },
                            ),

                            // TextFormField(
                            //   controller: _startController,
                            //   decoration: InputDecoration(
                            //       labelText: 'Start',
                            //       hintText: 'Enter start location',
                            //       border: OutlineInputBorder(
                            //           borderRadius: BorderRadius.circular(10)),
                            //       prefixIcon: const Icon(
                            //         Icons.location_on,
                            //         color: secondary,
                            //       ),
                            //       suffixIcon: IconButton(
                            //         icon: const Icon(Icons.search, color: primary),
                            //         onPressed: () {
                            //           setState(() {
                            //             startPressed = true;
                            //             searchNearbyBusesForStart(
                            //                 _startController.text);
                            //           });
                            //         },
                            //       )),
                            //   validator: canNotBeNull,
                            // ),
                            // BlocBuilder<HomeBloc, HomeState>(
                            //   builder: (context, state) {
                            //     if (state is NearByBusesForStartLoadingState) {
                            //       return Padding(
                            //           padding: EdgeInsets.only(top: 20.h),
                            //           child: const Center(
                            //               child: CircularProgressIndicator()));
                            //     } else if (state is NearByBusesForStartLoadedState) {
                            //       if (state.nearByBusesForStartList.isEmpty) {
                            //         return const SizedBox(
                            //           height: 0,
                            //         );
                            //       }
                            //       return Visibility(
                            //         visible: startPressed,
                            //         child: ListView.builder(
                            //           physics: const NeverScrollableScrollPhysics(),
                            //           shrinkWrap: true,
                            //           itemCount: state.nearByBusesForStartList.length,
                            //           itemBuilder: (context, index) {
                            //             return GestureDetector(
                            //                 onTap: () async {
                            //                   setState(() {
                            //                     _startController.text = state
                            //                         .nearByBusesForStartList[index];
                            //                     startPressed = false;
                            //                   });
                            //                 },
                            //                 child: ListTile(
                            //                   title: Text(state
                            //                       .nearByBusesForStartList[index]),
                            //                 ));
                            //           },
                            //         ),
                            //       );
                            //     } else if (state is LocationErrorState) {
                            //       return const SizedBox(
                            //         height: 0,
                            //       );
                            //     }
                            //     return const SizedBox(
                            //       height: 0,
                            //     );
                            //   },
                            // ),

                            // TextFormField(
                            //   controller: _destinationController,
                            //   decoration: InputDecoration(
                            //       labelText: 'Destination',
                            //       prefixIcon: const Icon(
                            //         Icons.location_on,
                            //         color: secondary,
                            //       ),
                            //       hintText: 'Enter your destination',
                            //       border: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10),
                            //       ),
                            //       suffixIcon: IconButton(
                            //         icon: const Icon(Icons.search, color: danger),
                            //         onPressed: () {
                            //           setState(() {
                            //             destinationPressed = true;
                            //             searchNearbyBusesForDestination(
                            //                 _destinationController.text);
                            //           });
                            //         },
                            //       )),
                            //   validator: canNotBeNull,
                            // ),
                            // BlocBuilder<HomeBloc, HomeState>(
                            //     builder: (context, state) {
                            //   if (state is NearByBusesForDestinationLoadingState) {
                            //     return const SizedBox(height: 0);
                            //   } else if (state
                            //       is NearByBusesForDestinationErrorState) {
                            //     return const SizedBox(height: 0);
                            //   } else if (state
                            //       is NearByBusesForDestinationLoadedState) {
                            //     return Visibility(
                            //       visible: destinationPressed,
                            //       child: ListView.builder(
                            //         physics: const NeverScrollableScrollPhysics(),
                            //         shrinkWrap: true,
                            //         itemCount:
                            //             state.nearByBusesForDestinationList.length,
                            //         itemBuilder: (context, index) {
                            //           return GestureDetector(
                            //               onTap: () {
                            //                 destinationPressed = false;
                            //                 _destinationController.text = state
                            //                     .nearByBusesForDestinationList[index];
                            //               },
                            //               child: ListTile(
                            //                 title: Text(
                            //                     state.nearByBusesForDestinationList[
                            //                         index]),
                            //               ));
                            //         },
                            //       ),
                            //     );
                            //   }
                            //   return const SizedBox(height: 0);
                            // }),

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
                                                  startStation:
                                                      _startController.text,
                                                  destinationStation:
                                                      _destinationController
                                                          .text,
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
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            SizedBox(height: 6.h),
                            BlocBuilder<HomeBloc, HomeState>(
                              builder: (context, state) {
                                if (state is AvailableBusesLoadingState) {
                                  return const CircularProgressIndicator(
                                    color: primary,
                                  );
                                } else if (state is AvailableBusesErrorState) {
                                  return Center(
                                      child: Text(state.errorMessage));
                                } else if (state is AvailableBusesLoadedState) {
                                  return Expanded(
                                    child: ListView.builder(
                                      itemCount:
                                          state.availableBusesList.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.only(top: 15.h),
                                          child: InkWell(
                                            onTap: () {
                                              (context).pushNamed(
                                                  AppPath
                                                      .realTimeVehicleTracking,
                                                  extra: {
                                                    "bus": state
                                                            .availableBusesList[
                                                        index],
                                                  });
                                            },
                                            child: CardWidget(
                                                bus: state
                                                    .availableBusesList[index]),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }
                                return const SizedBox(
                                  height: 0.0,
                                );
                                // return Expanded(
                                //   child: ListView.builder(
                                //     itemCount: buses.length,
                                //     itemBuilder: (context, index) {
                                //       return Padding(
                                //         padding: EdgeInsets.only(top: 15.h),
                                //         child: InkWell(
                                //           onTap: () {
                                //             (context).pushNamed(
                                //                 AppPath.realTimeVehicleTracking,
                                //                 extra: {
                                //                   "bus": buses[index],
                                //                 });
                                //           },
                                //           child: CardWidget(bus: buses[index]),
                                //         ),
                                //       );
                                //     },
                                //   ),
                                // );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height.h,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TypeAheadField(
                            controller: _startController,
                            hideOnEmpty: true,
                            hideOnLoading: true,
                            hideOnUnfocus: true,
                            itemBuilder: (context, state) {
                              return ListTile(
                                tileColor: white,
                                title: Text(state.toString()),
                              );
                            },
                            onSelected: (val) {
                              _startController.text = val;
                            },
                            suggestionsCallback: (search) =>
                                getSuggestions(search, stations),
                            builder: (context, controller, focusNode) {
                              return TextFormField(
                                controller: controller,
                                focusNode: focusNode,
                                decoration: InputDecoration(
                                  labelText: 'Start',
                                  hintText: 'Enter start location',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  prefixIcon: const Icon(
                                    Icons.location_on,
                                    color: secondary,
                                  ),
                                ),
                                validator: canNotBeNull,
                              );
                            },
                          ),
                          SizedBox(height: 20.h),
                          TypeAheadField(
                            controller: _destinationController,
                            hideOnEmpty: true,
                            hideOnLoading: true,
                            hideOnUnfocus: true,
                            itemBuilder: (context, state) {
                              return ListTile(
                                tileColor: white,
                                title: Text(state.toString()),
                              );
                            },
                            onSelected: (val) {
                              _destinationController.text = val;
                            },
                            suggestionsCallback: (search) =>
                                getSuggestions(search, stations),
                            builder: (context, controller, focusNode) {
                              return TextFormField(
                                controller: controller,
                                focusNode: focusNode,
                                decoration: InputDecoration(
                                  labelText: 'Destination',
                                  hintText: 'Enter Destination location',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  prefixIcon: const Icon(
                                    Icons.location_on,
                                    color: secondary,
                                  ),
                                ),
                                validator: canNotBeNull,
                              );
                            },
                          ),
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
                                                startStation:
                                                    _startController.text,
                                                destinationStation:
                                                    _destinationController.text,
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
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
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
                                return Expanded(
                                  child: ListView.builder(
                                    itemCount: state.availableBusesList.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(top: 15.h),
                                        child: InkWell(
                                          onTap: () {
                                            (context).pushNamed(
                                                AppPath.realTimeVehicleTracking,
                                                extra: {
                                                  "bus":
                                                      state.availableBusesList[
                                                          index],
                                                });
                                          },
                                          child: CardWidget(
                                              bus: state
                                                  .availableBusesList[index]),
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
              );
            },
          ),
        ),
      ),
    );
  }
}

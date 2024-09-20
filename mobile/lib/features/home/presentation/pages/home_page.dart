import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
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
    context.read<HomeBloc>().add(GetStationNamesEvent());
    super.initState();
  }

  // @override
  // void dispose() {
  //   _startController.dispose();
  //   _destinationController.dispose();
  //   super.dispose();
  // }

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

  static List<String> getSuggestions(String query, states) {
    List<String> matches = [];
    matches.addAll(states);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is GetStationNamesErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.errorMessage), backgroundColor: danger));
          } else if (state is AvailableBusesErrorState) {
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
                                    controller: controller,
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
                              const SizedBox(height: 30),
                              Center(
                                child: ButtonWidget(
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
                                    }),
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
                                  } else if (state
                                      is AvailableBusesErrorState) {
                                    return Center(
                                        child: Text(state.errorMessage));
                                  } else if (state
                                      is AvailableBusesLoadedState) {
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
                                                  bus: state.availableBusesList[
                                                      index]),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                  return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 20.h),
                                        Lottie.asset(
                                          'assets/images/no_data_available.json',
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                        ),
                                      ]);
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
                                    getSuggestions(search, stations),
                                builder: (context, controller, focusNode) {
                                  return TextFormField(
                                    controller: controller,
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
                              const SizedBox(height: 30),
                              Center(
                                child: ButtonWidget(
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
                                    }),
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
                                  } else if (state
                                      is AvailableBusesErrorState) {
                                    return Center(
                                        child: Text(state.errorMessage));
                                  } else if (state
                                      is AvailableBusesLoadedState) {
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
                                                  bus: state.availableBusesList[
                                                      index]),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                  return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 20.h),
                                        Lottie.asset(
                                          'assets/images/no_data_available.json',
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                        ),
                                      ]);
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
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:transittrack/core/routes/route_path.dart';
import 'package:transittrack/core/theme.dart';
import 'package:transittrack/core/widgets/custom_appbar_widget.dart';
import 'package:transittrack/features/home/presentation/widgets/card_widget.dart';
import 'package:transittrack/features/my_route/presentation/bloc/my_route_bloc.dart';

class MyRoute extends StatefulWidget {
  const MyRoute({super.key});

  @override
  State<MyRoute> createState() => _MyRouteState();
}

class _MyRouteState extends State<MyRoute> {
  TextEditingController startController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    startController.dispose();
    destinationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    context.read<MyRouteBloc>().add(GetMyRouteEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyRouteBloc, MyRouteState>(
      listener: (context, state) {
        if (state is GetMyRouteErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
            ),
          );
        } else if (state is AddBusToMyRouteErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
            ),
          );
        } else if (state is RemoveBusFromMyRouteErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
            ),
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: white,
          appBar: const CustomAppBarWidget(),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 20
                          .h), // Spacing between the input section and tickets
                  Text(
                    "My Routes",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // The ticket list area
                  BlocBuilder<MyRouteBloc, MyRouteState>(
                    builder: (context, state) {
                      if (state is GetMyRouteLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is GetMyRouteErrorState) {
                        return Center(
                          child: Text(state.errorMessage),
                        );
                      } else if (state is GetMyRouteLoadedState) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: state.buses.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(top: 15.h),
                                child: InkWell(
                                  onTap: () {
                                    (context).pushNamed(
                                        AppPath.realTimeVehicleTracking,
                                        extra: {
                                          "bus": state.buses[index],
                                        });
                                  },
                                  child: CardWidget(bus: state.buses[index]),
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return const Center(
                        child: Text("No buses added to your route"),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

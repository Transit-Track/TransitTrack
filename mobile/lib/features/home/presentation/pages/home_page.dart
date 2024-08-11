import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transittrack/core/routes/route_path.dart';
import 'package:transittrack/core/theme.dart';
import 'package:transittrack/core/widgets/button_widget.dart';
import 'package:transittrack/core/widgets/custom_appbar_widget.dart';
import 'package:transittrack/core/widgets/custom_navbar_widget.dart';
import 'package:transittrack/features/home/presentation/bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final String token = "1234567546";

  // var uuid = Uuid();
  List<dynamic> listOfLocation = [];

  @override
  void initState() {
    super.initState();
    _startController.addListener(() {
      _onChange(_startController.text);
    });
    _destinationController.addListener(() {
      _onChange(_destinationController.text);
    });
  }

  @override
  void dispose() {
    _startController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  _onChange(String place) {
    palceSuggestion(place);
  }

  void palceSuggestion(String input) async {
    context.read<HomeBloc>().add(GetLocationEvent(input: input));
  }

  // void palceSuggestion(String input) async {
  //   const String apiKey = "";
  //   try {
  //     String baseUrl =
  //         "https://maps.googleapis.com/maps/api/place/autocomplete/json";
  //     String request = '$baseUrl?input=$input&key=$apiKey&sessiontoken=$token';
  //     var response = await http.get(Uri.parse(request));
  //     var data = json.decode(response.body);

  //     if (kDebugMode) {
  //       print(data);
  //     }

  //     if (response.statusCode == 200) {
  //       setState(() {
  //         listOfLocation = json.decode(response.body)['predictions'];
  //       });
  //     } else {
  //       throw Exception('Failed to load data');
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is LocationErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: white,
          appBar: const CustomAppBarWidget(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 20, 8, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: SizedBox(
                      height: 500,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _startController,
                            decoration: InputDecoration(
                              labelText: 'Start',
                              hintText: 'Enter your starting location',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              prefixIcon: Icon(
                                Icons.location_on,
                                color: secondary,
                              ),
                          suffixIcon: IconButton(icon: const Icon(Icons.search), onPressed: () {

                          },)
                            ),
                          
                          ),
                          Visibility(
                            visible: _startController.text.isNotEmpty,
                            child: Expanded(
                                child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: listOfLocation.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      print(
                                          '$index -----------------------------------------------------');
                                    },
                                    child: ListTile(
                                      title: Text(_startController.text =
                                          listOfLocation[index]['description']),
                                    ));
                              },
                            )),
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
                            ),
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                          Visibility(
                            visible: _destinationController.text.isNotEmpty,
                            child: Expanded(
                                child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {},
                                    child: ListTile(
                                      title: Text(
                                          listOfLocation[index]['description']),
                                    ));
                              },
                            )),
                          ),
                          const SizedBox(height: 30),
                          ButtonWidget(
                              context: context,
                              text: 'Search',
                              onClick: () {
                                (context).goNamed(AppPath.test);
                              })
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
          bottomNavigationBar: CustomNavbarWidget(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:transittrack/core/routes/route_path.dart';
import 'package:transittrack/core/theme.dart';
import 'package:transittrack/core/widgets/button_widget.dart';
import 'package:transittrack/core/widgets/custom_appbar_widget.dart';
import 'package:transittrack/core/widgets/custom_navbar_widget.dart';
import 'package:transittrack/env/env.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  Placemark _pickPlaceMark = Placemark();
  Placemark get pickPlaceMark => _pickPlaceMark;

  late GoogleMapsPlaces _places;

  @override
  void initState() {
    super.initState();
    _places = GoogleMapsPlaces(apiKey: Env.googleApiKey);
  }

  @override
  void dispose() {
    _startController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  Future<String?> showGoogleAutoComplete() async {
    void onError(PlacesAutocompleteResponse response) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.errorMessage ?? 'Unknown error'),
        ),
      );
    }

    final Prediction? prediction = await PlacesAutocomplete.show(
      offset: 0,
      radius: 1000,
      strictbounds: false,
      region: "et",
      language: "en",
      context: context,
      mode: Mode.overlay,
      apiKey: Env.googleApiKey,
      components: [new Component(Component.country, "et")],
      types: ["(cities)"],
      hint: "Search City",
    );

    return prediction!.description;
  }

  void autoCompleteSearch(value) async {
    var result = await _places.autocomplete(value);
    print(result.predictions);
    if (result.predictions.isNotEmpty && mounted) {
      print(result.predictions[0].description);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _startController,
                        decoration: InputDecoration(
                            labelText: 'Start',
                            hintText: 'Enter your start location',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        readOnly: true,
                        controller: _destinationController,
                        decoration: InputDecoration(
                          // labelText: 'Destination',
                          prefixIcon: Icon(
                            Icons.location_on,
                            color: secondary,
                          ),
                          hintText: 'Enter your destination location',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        // onTap: () async {
                        //   String? selectedPlace =
                        //       await showGoogleAutoComplete();
                        //   _destinationController.text = selectedPlace!;
                        // },
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            _places
                                .autocomplete(value)
                                .asStream()
                                .listen((event) {
                              print(event.predictions);
                            });
                          }
                        },
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
    );
  }
}

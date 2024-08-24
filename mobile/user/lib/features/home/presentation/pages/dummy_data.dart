import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:transittrack/features/home/domain/entities/bus.dart';
import 'package:transittrack/features/home/domain/entities/driver_entity.dart';

List<Bus> buses = [
  const Bus(
      arrivalTime: "1min",
      destination: "Megenagna",
      id: "",
      imageUrl: "assets/images/anbessa.png",
      latitude: "",
      longitude: "",
      number: "17",
      price: "",
      routes: [],
      start: "",
      stationName: 'Kidist Mariam',
      distance: '10'),
  const Bus(
      arrivalTime: "2min",
      destination: "",
      id: "",
      imageUrl: "assets/images/anbessa.png",
      latitude: "",
      longitude: "",
      number: "83",
      price: "",
      routes: [],
      start: "",
      stationName: '4 kilo station',
      distance: '23'),
  const Bus(
      arrivalTime: "3min",
      destination: "",
      id: "",
      imageUrl: "assets/images/anbessa.png",
      latitude: "",
      longitude: "",
      number: "16",
      price: "",
      routes: [],
      start: "",
      stationName: 'yared station',
      distance: '5'),
  const Bus(
      arrivalTime: "4min",
      destination: "",
      id: "",
      imageUrl: "assets/images/anbessa.png",
      latitude: "",
      longitude: "",
      number: "64",
      price: "",
      routes: [],
      start: "",
      stationName: '6 kilo station',
      distance: '21'),
];

DriverEntity driver = const DriverEntity(
  latitude: 9.0208,
  longitude: 38.7469,
);
LatLng driverLocation = LatLng(driver.latitude, driver.longitude);

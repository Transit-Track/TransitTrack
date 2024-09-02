import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:transittrack/features/home/domain/entities/bus.dart';
import 'package:transittrack/features/home/domain/entities/driver_entity.dart';

List<BusEntity> buses = [
  const BusEntity(
      arrivalTime: "1",
      destination: "Megenagna",
      id: "",
      imageUrl: "assets/images/anbessa.png",
      latitude: "",
      longitude: "",
      number: "17",
      price: "10",
      routes: [
    {'name': 'Shiro Meda', 'latitude': 9.0500, 'longitude': 38.7500},
    {'name': 'Arat Kilo', 'latitude': 9.0450, 'longitude': 38.7600},
    {'name': 'Piassa', 'latitude': 9.0400, 'longitude': 38.7700},
    {'name': 'Stadium', 'latitude': 9.0350, 'longitude': 38.7800},
    {'name': 'Meskel Square', 'latitude': 9.0300, 'longitude': 38.7900},
    {'name': 'Mexico', 'latitude': 9.0250, 'longitude': 38.8000},
  ],
      start: "4Kilo",
      stationName: 'Kidist Mariam',
      distance: '10'),
  const BusEntity(
      arrivalTime: "2",
      destination: "Mexico   ",
      id: "",
      imageUrl: "assets/images/anbessa.png",
      latitude: "",
      longitude: "",
      number: "83",
      price: "15",
      routes: [
    {'name': 'Shiro Meda', 'latitude': 9.0500, 'longitude': 38.7500},
    {'name': 'Arat Kilo', 'latitude': 9.0450, 'longitude': 38.7600},
    {'name': 'Piassa', 'latitude': 9.0400, 'longitude': 38.7700},
    {'name': 'Stadium', 'latitude': 9.0350, 'longitude': 38.7800},
    {'name': 'Meskel Square', 'latitude': 9.0300, 'longitude': 38.7900},
    {'name': 'Mexico', 'latitude': 9.0250, 'longitude': 38.8000},
  ],
      start: "5kilo",
      stationName: '4 kilo station',
      distance: '23'),
  const BusEntity(
      arrivalTime: "3",
      destination: "6kilo    ",
      id: "",
      imageUrl: "assets/images/anbessa.png",
      latitude: "",
      longitude: "",
      number: "16",
      price: "10",
      routes: [
    {'name': 'Shiro Meda', 'latitude': 9.0500, 'longitude': 38.7500},
    {'name': 'Arat Kilo', 'latitude': 9.0450, 'longitude': 38.7600},
    {'name': 'Piassa', 'latitude': 9.0400, 'longitude': 38.7700},
    {'name': 'Stadium', 'latitude': 9.0350, 'longitude': 38.7800},
    {'name': 'Meskel Square', 'latitude': 9.0300, 'longitude': 39.0900},
    {'name': 'Mexico', 'latitude': 9.0250, 'longitude': 39.8000},
  ],
      start: "legehar",
      stationName: 'yared station',
      distance: '5'),
  const BusEntity(
      arrivalTime: "4",
      destination: "Mexico     ",
      id: "",
      imageUrl: "assets/images/anbessa.png",
      latitude: "",
      longitude: "",
      number: "64",
      price: "5",
      routes: [
    {'name': 'Shiro Meda', 'latitude': 9.0500, 'longitude': 38.7500},
    {'name': 'Arat Kilo', 'latitude': 9.0450, 'longitude': 38.7600},
    {'name': 'Piassa', 'latitude': 9.0400, 'longitude': 38.7700},
    {'name': 'Stadium', 'latitude': 9.0350, 'longitude': 38.7800},
    {'name': 'Meskel Square', 'latitude': 9.0300, 'longitude': 38.7900},
    {'name': 'Mexico', 'latitude': 9.0250, 'longitude': 38.8000},
  ],
      start: "Shola",
      stationName: '6 kilo station',
      distance: '21'),
];

DriverEntity driver = const DriverEntity(
  latitude: 9.0208,
  longitude: 38.7469,
);
LatLng driverLocation = LatLng(driver.latitude, driver.longitude);
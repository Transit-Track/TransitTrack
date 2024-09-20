import 'package:transittrack/features/driver/domain/entity/driver_entity.dart';
import 'package:transittrack/features/driver/domain/entity/driver_location_entity.dart';
import 'package:transittrack/features/home/domain/entities/bus_entity.dart';
import 'package:transittrack/features/home/domain/entities/route_entity.dart';
import 'package:transittrack/features/home/domain/entities/station_entity.dart';

List<BusEntity> buses = [
  const BusEntity(
    isMyRoute: true,
    driver: DriverEntity(
        phoneNumber: "2514567789",
        location: LocationEntity(longitude: 9.0, latitude: 8.9)),
    arrivalTime: "1",
    id: "",
    type: "anbessa",
    number: "17",
    price: 10,
    route: RouteEntity(distance: 10.3, id: '1',
    stations: [
      StationEntity(
          stationId: '1',
          name: 'Shiro Meda',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '2',
          name: '4 Kilo',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '3',
          name: 'Piassa',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '4',
          name: 'Stadium',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '5',
          name: 'Meskel Square',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '6',
          name: 'Mexico',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
    ],
    )
  ),
  const BusEntity(
      isMyRoute: true,
      driver: DriverEntity(
          phoneNumber: "2514567789",
          location: LocationEntity(longitude: 9.0, latitude: 8.9)),
      arrivalTime: "2",
      id: "",
      type: "anbessa",
      number: "83",
      price: 15,
        route: RouteEntity(distance: 10.3, id: '1',
    stations: [
      StationEntity(
          stationId: '1',
          name: 'Shiro Meda',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '2',
          name: '4 Kilo',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '3',
          name: 'Piassa',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '4',
          name: 'Stadium',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '5',
          name: 'Meskel Square',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '6',
          name: 'Mexico',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
    ],
    )
      ),
  const BusEntity(
      isMyRoute: false,
      driver: DriverEntity(
          phoneNumber: "2514567789",
          location: LocationEntity(longitude: 9.0, latitude: 8.9)),
      arrivalTime: "3",
      id: "",
      type: "anbessa",
      number: "16",
      price: 10,
        route: RouteEntity(distance: 10.3, id: '1',
    stations: [
      StationEntity(
          stationId: '1',
          name: 'Shiro Meda',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '2',
          name: '4 Kilo',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '3',
          name: 'Piassa',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '4',
          name: 'Stadium',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '5',
          name: 'Meskel Square',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '6',
          name: 'Mexico',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
    ],
    )
      ),
  const BusEntity(
      isMyRoute: false,
      driver: DriverEntity(
          phoneNumber: "2514567789",
          location: LocationEntity(longitude: 9.0, latitude: 8.9)),
      arrivalTime: "4",
      id: "",
      type: "anbessa",
      number: "64",
      price: 5,
        route: RouteEntity(distance: 10.3, id: '1',
    stations: [
      StationEntity(
          stationId: '1',
          name: 'Shiro Meda',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '2',
          name: '4 Kilo',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '3',
          name: 'Piassa',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '4',
          name: 'Stadium',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '5',
          name: 'Meskel Square',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '6',
          name: 'Mexico',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
    ],
    )
      ),
];

List<BusEntity> myRoutes = [
  const BusEntity(
      isMyRoute: true,
      driver: DriverEntity(
          phoneNumber: "2514567789",
          location: LocationEntity(longitude: 9.0, latitude: 8.9)),
      arrivalTime: "1",
      id: "",
      type: "anbessa",
      number: "17",
      price: 10,
        route: RouteEntity(distance: 10.3, id: '1',
    stations: [
      StationEntity(
          stationId: '1',
          name: 'Shiro Meda',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '2',
          name: '4 Kilo',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '3',
          name: 'Piassa',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '4',
          name: 'Stadium',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '5',
          name: 'Meskel Square',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '6',
          name: 'Mexico',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
    ],
    )
      ),
  const BusEntity(
      isMyRoute: true,
      driver: DriverEntity(
          phoneNumber: "2514567789",
          location: LocationEntity(longitude: 9.0, latitude: 8.9)),
      arrivalTime: "2",
      id: "",
      type: "anbessa",
      number: "83",
      price: 15,
        route: RouteEntity(distance: 10.3, id: '1',
    stations: [
      StationEntity(
          stationId: '1',
          name: 'Shiro Meda',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '2',
          name: '4 Kilo',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '3',
          name: 'Piassa',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '4',
          name: 'Stadium',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '5',
          name: 'Meskel Square',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '6',
          name: 'Mexico',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
    ],
    )
      ),
];

List<BusEntity> notifications = [
  const BusEntity(
      isMyRoute: true,
      driver: DriverEntity(
          phoneNumber: "2514567789",
          location: LocationEntity(longitude: 9.0, latitude: 8.9)),
      arrivalTime: "1",
      id: "",
      type: "anbessa",
      number: "17",
      price: 10,
        route: RouteEntity(distance: 10.3, id: '1',
    stations: [
      StationEntity(
          stationId: '1',
          name: 'Shiro Meda',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '2',
          name: '4 Kilo',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '3',
          name: 'Piassa',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '4',
          name: 'Stadium',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '5',
          name: 'Meskel Square',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '6',
          name: 'Mexico',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
    ],
    )
      ),
  const BusEntity(
      isMyRoute: true,
      driver: DriverEntity(
          phoneNumber: "2514567789",
          location: LocationEntity(longitude: 9.0, latitude: 8.9)),
      arrivalTime: "2",
      id: "",
      type: "anbessa",
      number: "83",
      price: 15,
        route: RouteEntity(distance: 10.3, id: '1',
    stations: [
      StationEntity(
          stationId: '1',
          name: 'Shiro Meda',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '2',
          name: '4 Kilo',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '3',
          name: 'Piassa',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '4',
          name: 'Stadium',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '5',
          name: 'Meskel Square',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
      StationEntity(
          stationId: '6',
          name: 'Mexico',
          geoLocation: LocationEntity(longitude: 9.087, latitude: 31.875)),
    ],
    )
      ),
];

// DriverEntity driver = const DriverEntity(
//   latitude: 9.0208,
//   longitude: 38.7469,
// );
// LatLng driverLocation = LatLng(driver.latitude, driver.longitude);

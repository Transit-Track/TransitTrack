import 'package:equatable/equatable.dart';

class Ticket extends Equatable {
  final String ticketId;
  final String userId;
  final String busId;
  final DateTime issueDate;
  final String start;
  final String destination;
  final double price;
  final DateTime expiryDate;
  final String status;
  final String arrivalTime;

  const Ticket({
    required this.ticketId,
    required this.userId,
    required this.busId,
    required this.issueDate,
    required this.start,
    required this.destination,
    required this.price,
    required this.expiryDate,
    required this.status,
    required this.arrivalTime,
  });

 @override
  List<Object?> get props => [
    ticketId,
    userId,
    busId,
    issueDate,
    start,
    destination,
    price,
    expiryDate,
    status,
    arrivalTime,
  ];
}
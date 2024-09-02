class Ticket {
  final String ticketId;
  final String userId;
  final String busId;
  final DateTime issueDate;
  final String start;
  final String destination;
  final double price;
  final DateTime expiryDate;
  final String status;

  Ticket({
    required this.ticketId,
    required this.userId,
    required this.busId,
    required this.issueDate,
    required this.start,
    required this.destination,
    required this.price,
    required this.expiryDate,
    required this.status,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Ticket &&
      other.ticketId == ticketId &&
      other.userId == userId &&
      other.busId == busId &&
      other.issueDate == issueDate &&
      other.start == start &&
      other.destination == destination &&
      other.price == price &&
      other.expiryDate == expiryDate &&
      other.status == status;
  }


}
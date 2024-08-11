import 'package:transittrack/features/home/domain/entities/bus.dart';

abstract class HomeRemoteDataSource {
 Future<List<Bus>> getbuses(String start, String destination);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  
  @override
  Future<List<Bus>> getbuses(String start, String destination) {
    // TODO: implement getbuses
    throw UnimplementedError();
  }
}

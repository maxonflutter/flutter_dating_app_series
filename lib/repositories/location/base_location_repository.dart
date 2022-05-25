import '../../models/models.dart';

abstract class BaseLocationRepository {
  Future<Location?> getLocation(String placeId);
}

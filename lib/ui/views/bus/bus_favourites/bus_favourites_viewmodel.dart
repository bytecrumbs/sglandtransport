import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/services/favourites_service.dart';
import 'package:stacked/stacked.dart';

class BusFavouritesViewModel extends FutureViewModel<List<String>> {
  final _favouritesService = locator<FavouritesService>();
  final String _title = 'Favourites';
  String get title => _title;

  @override
  Future<List<String>> futureToRun() =>
      _favouritesService.getFavouriteBusStops();
}

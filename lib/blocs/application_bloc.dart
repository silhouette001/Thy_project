import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_api1/models/places_search.dart';
import 'package:map_api1/services/geolocator_service.dart';
import 'package:map_api1/services/places_service.dart';


class ApplicationBloc with ChangeNotifier{
  final geolocatorService= GeolocatorService();
  final placesService = PlacesService();

  Position currentLocation;
  List<PlaceSearch> searchResults;

  ApplicationBloc(){
    setCurrentLocation();
  }

  setCurrentLocation()  async{
    currentLocation= await geolocatorService.getCurrentLocation();
    notifyListeners();
  }
  searchPlaces(String searchTerm) async{
    searchResults= await placesService.getAutocomplete(searchTerm);
    notifyListeners();
  }
}
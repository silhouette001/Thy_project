import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:map_api1/models/places_search.dart';

class PlacesService{
  final key='AIzaSyAV3HDHI8rZ2tJdw_gY4jE4oLsu06pECjc';
  Future<List<PlaceSearch>>getAutocomplete(String search) async{
    var url=Uri.parse('https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=(cities)&key=$key');
    var response= await http.get(url);
    var json=convert.jsonDecode(response.body);
    var jsonResults=json['predictions']as List;
    return jsonResults.map((place)=>PlaceSearch.fromJson(place)).toList();
  }
}
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_api1/blocs/application_bloc.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final applicationBloc=Provider.of<ApplicationBloc>(context);

    return Scaffold(
      body:(applicationBloc.currentLocation==null)
      ?Center(
        child:CircularProgressIndicator() ,
        )
      :ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(hintText: 'Search Location',
              suffixIcon:Icon(Icons.search),
              ),
              onChanged: (value)=>applicationBloc.searchPlaces(value)
              ),

            ),
          
          Stack(
            children: [
              Container(
                height:300.0,
                child: GoogleMap(
                  mapType: MapType.normal,
                  myLocationButtonEnabled: true,
                  initialCameraPosition: 
                  CameraPosition(target: LatLng(applicationBloc.currentLocation.latitude,applicationBloc.currentLocation.longitude),
                  zoom:14),
                ),
              ),
              if(applicationBloc.searchResults!=null&& 
                 applicationBloc.searchResults.length!=0)
                Container(
                height: 300.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.6),
                  backgroundBlendMode: BlendMode.darken
                ),
              ) ,
              Container(
                height: 300.0,
                child:ListView.builder(
                  itemCount: applicationBloc.searchResults.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      title:Text(applicationBloc.searchResults[index].description,
                      style: TextStyle(color:Colors.white),
                      ),
                    );
                  },),
              ),
            ],
          )
        ],
      ),
      
    );
  }
}
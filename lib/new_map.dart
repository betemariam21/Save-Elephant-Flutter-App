import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _initialCameraPosition = CameraPosition(target: LatLng(37.773972, -122.431297),
    zoom: 11.5,
  );
  late GoogleMapController _googleMapController;//for the floating action button
   Marker? _origin;
   Marker? _destination;
  @override
  void dispose() {
    // TODO: implement dispose
    _googleMapController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (controller) => _googleMapController = controller,
        onLongPress: _addMarker,

        //markers: _origin,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController.animateCamera(CameraUpdate.newCameraPosition(_initialCameraPosition),),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }
void _addMarker(LatLng pos){

    if(_origin == null || (_origin != null && _destination != null)){
      setState(() {
        _origin=Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
       // _destination = null;
      });

    }
    else {
      setState(() {
        _origin=Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
        // _destination = null;
      });


    }
}
}

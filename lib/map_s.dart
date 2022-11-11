import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:save_elephants/alerts.dart';
import 'package:save_elephants/setting.dart';

class map_s extends StatefulWidget {

  const map_s({Key? key}) : super(key: key);
  @override
  _map_sState createState() => _map_sState();

}

class _map_sState extends State<map_s> {
  final fb = FirebaseDatabase.instance;
  var stress = '0';
  bool isstresstrue = true;
  var stress_2 = '0';
  var stress_3 = '0';
  double _stress1 = 0.0;
  double _stress2 = 0.0;
  double _stress3 = 0.0;
  var lat = 0.0 ;
  var lon = 0.0 ;

  late Query ref1;
  late Query ref2;
  late Query ref3;
  late Query ref4;
  late Query ref5;
  bool clicks = true;
  bool clicks_2 = true;
  bool clicks_3 = false;
  bool clicks_4 = true;
  bool clicks_5 = true;
  bool buttontou_ = true;
  final LatLng point1 = const LatLng(9.029668, 38.771036);
  final LatLng point2 = const LatLng(9.029866, 38.757095);
  final LatLng point3 = const LatLng(9.046570, 38.759332);
  final LatLng point4 = const LatLng(9.045482, 38.786151);


  static const LatLng SOURCE_LOCATION = LatLng(13.652720, 100.493635);
  static const LatLng DEST_LOCATION = LatLng(13.6640896, 100.4357021);
  static const LatLng SOURCE = LatLng(9.03999521987325, 38.761466602588854);
  static const LatLng DEST = LatLng(9.021205, 38.735107);
  static const LatLng SOURCE_2 = LatLng(9.142317, 38.868219);
  static const LatLng SOURCE_3 = LatLng(9.221205, 38.935107);
  static const LatLng SOURCE_4 = LatLng(9.321205, 38.985107);
  static const LatLng SOURCE_LOCATION_2 = LatLng(6.852720, 36.693635);
  static const LatLng DEST_LOCATION_2 = LatLng(6.6640896, 36.4357021);
  static const LatLng SOURCE_LOCATION_3 = LatLng(6.8640896, 36.6357021);
  static const LatLng DEST_LOCATION_3 = LatLng(6.867529, 36.616893);
  static const LatLng SOURCE_LOCATION_4 =
      LatLng(6.86752953462916, 36.616893753526);
  static const LatLng DEST_LOCATION_4 =
      LatLng(6.85752953462916, 36.606893753526);
  int index = 1;
  Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController controller;
  List<Marker> markers = [];
  Set<Marker> _markers = Set<Marker>();
  late LatLng current_fb;
  late LatLng destination_fb;

  late LatLng currentLocation;
  late LatLng destinationLocation;
  late LatLng current;
  late LatLng destination;
  late LatLng current_2;
  late LatLng current_3;
  late LatLng current_4;
  late LatLng currentLocation_2;
  late LatLng destinationLocation_2;
  late LatLng currentLocation_3;
  late LatLng destinationLocation_3;
  late LatLng currentLocation_4;
  late LatLng destinationLocation_4;
  static bool boundary_1 = false;
  static bool boundary_2 = false;
  static bool boundary_3 = false;

  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyAgryGM0W7_UkWuLA3qcmcTrY2QkCxFxjw";
  final Set<Polyline> _polyline = {};
  final Set<Polygon> _polygone = HashSet<Polygon>();
  bool map_s = true;
  List<LatLng> points = [
    // LatLng(8.991162, 38.759211),
    // LatLng(9.011156, 38.797622),
    // LatLng(9.031583, 38.799748),
    // LatLng(9.066175, 38.783887),
    // LatLng(9.066175, 38.743572),
    // LatLng(9.042679, 38.709866),
    // LatLng(9.031934, 38.699333),
    // LatLng(9.004184, 38.721707),
    // LatLng(8.996989, 38.751366),
    //LatLng(8.991162, 38.759211),
    LatLng(9.029668, 38.771036),
    LatLng(9.029866, 38.757095),
    LatLng(9.046570, 38.759332),
    LatLng(9.045482, 38.786151),
    LatLng(9.029668, 38.771036),

  ];
  late List<LatLng> routeCoords;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(6.88752953462916, 36.636893753526),
    zoom: 14.4746,
  );
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(6.88752953462916, 36.636893753526),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  static final CameraPosition _kLake_2 = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(6.87752953462916, 36.626893753526),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  static final CameraPosition _kLake_3 = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(6.86752953462916, 36.616893753526),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  static final CameraPosition _kLake_4 = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(6.85752953462916, 36.606893753526),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  static final CameraPosition source = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(9.03999521987325, 38.761466602588854),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  static final CameraPosition source_2 = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(9.142317, 38.868219),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  static final CameraPosition source_3 = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(9.221205, 38.935107),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  static final CameraPosition wild = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(9.021205, 38.735107),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  void change(){
    lat = 1;
    lon = 1;

  }
  void setInitialLocation() {
    //print('betaa'+lon.toString()+lat.toString());
    current_fb = LatLng(lon, lat);
    destination_fb = LatLng(DEST.latitude, DEST.longitude);
    currentLocation =
        LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude);
    destinationLocation =
        LatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude);
    current = LatLng(SOURCE.latitude, SOURCE.longitude);
    destination = LatLng(DEST.latitude, DEST.longitude);
    current_2 = LatLng(SOURCE_2.latitude, SOURCE_2.longitude);
    current_3 = LatLng(SOURCE_3.latitude, SOURCE_3.longitude);
    current_4 = LatLng(SOURCE_4.latitude, SOURCE_4.longitude);
    currentLocation_2 =
        LatLng(SOURCE_LOCATION_2.latitude, SOURCE_LOCATION_2.longitude);
    destinationLocation_2 =
        LatLng(DEST_LOCATION_2.latitude, DEST_LOCATION_2.longitude);
    currentLocation_3 =
        LatLng(SOURCE_LOCATION_3.latitude, SOURCE_LOCATION_3.longitude);
    destinationLocation_3 =
        LatLng(DEST_LOCATION_3.latitude, DEST_LOCATION_3.longitude);
    currentLocation_4 =
        LatLng(SOURCE_LOCATION_4.latitude, SOURCE_LOCATION_4.longitude);
    destinationLocation_4 =
        LatLng(DEST_LOCATION_4.latitude, DEST_LOCATION_4.longitude);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

     _polygone.add(Polygon(
      polygonId: PolygonId('1'),
      points: points,
      fillColor: Colors.lightGreen.withOpacity(0.3),
      geodesic: true,
      strokeWidth: 4,
      strokeColor: Colors.lightGreen,
    ));
    polylinePoints = PolylinePoints();
    loadData();
    change();
    DatabaseReference dbref_E_1 =
        FirebaseDatabase.instance.ref('Elephant1/dsdjsdkjskd/stress');
    dbref_E_1.onValue.listen((DatabaseEvent event) {
      final stress_ = event.snapshot.value.toString();
      //lat = lat_;
      //stress = double.parse(stress_);
      _stress1 = double.parse(stress_);
    });
    DatabaseReference dbref_E_2 =
        FirebaseDatabase.instance.ref('Elephant12/dhsjdsdjsdj/stress');
    dbref_E_2.onValue.listen((DatabaseEvent event) {
      final stress_ = event.snapshot.value.toString();
      //lat = lat_;
      //stress_2 = double.parse(stress_);
      _stress2 = double.parse(stress_);
    });
    DatabaseReference dbref_E_3 =
        FirebaseDatabase.instance.ref('Elephant3/dhjsjhds/stress');
    dbref_E_3.onValue.listen((DatabaseEvent event) {
      final stress_ = event.snapshot.value.toString();
      //lat = lat_;
      //stress_3 = double.parse(stress_);
      _stress3 = double.parse(stress_);
    });

    DatabaseReference dbref = FirebaseDatabase.instance.ref('Elephant5/lat');
    dbref.onValue.listen((DatabaseEvent event) {
      final lat_ = event.snapshot.value.toString();
      //lat = lat_;
      lat = double.parse(lat_);
      //be = double.parse(lat_);
      print(lat);
    });
    DatabaseReference dbref_2 = FirebaseDatabase.instance.ref('Elephant5/lon');
    dbref_2.onValue.listen((DatabaseEvent event) {
      final lon_ = event.snapshot.value.toString();
      //lat = lat_;

     // be_2 = double.parse(lon_);
      print(lon);
      setState(() {
        lon = double.parse(lon_);
      });
    });
    //Fluttertoast.showToast(msg: 'latitute'+lat.toString()+'lon '+lon.toString(),toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.BOTTOM);
    // print('betateeee'+lat.toString()+lon.toString());
    //lat = be;
    //lon = be_2;
    setInitialLocation();
    showMarker();
    ref1 = fb.ref().child('Elephant1');
    ref2 = fb.ref().child('Elephant12');
    ref3 = fb.ref().child('Elephant3');
    ref4 = fb.ref().child('ElephantMain');

    // ref5 = fb.ref().child('Elephant5');

    //intilize();
  }

  Widget _buildContactItem({Map? contact}) {

    return SafeArea(
      child: Column(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Container(
                margin: const EdgeInsets.only(top:15),
                padding: const EdgeInsets.only(left: 5.0, right: 25.0),
                child: Row(
                  children: [
                       const Icon(
                        Icons.warning,
                        color: Colors.red,
                        size: 35,
                      ),

                    const SizedBox(
                       width: 25,
                     ),
                    const Text(
                      'Elephant Status',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 0.5,
          ),

          Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: 90,
                  height: 90,
                  margin: const EdgeInsets.only(left: 25.0),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      contact!["heartbeat"].toString()+' BPM',
                     //contact!["heartbeat"],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 80,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Image.asset(
                        'images/stress.png',
                        width: 53.0,
                        height: 49.0,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: contact["stress"] == 0? Text(
                          'Stress Sound Not Detected',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 10.0,
                          ),
                        ):Text(
                          'Stress Sound Detected',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 10.0,
                          )

                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: [
                      Center(
                        child: Image.asset(
                          'images/gun.png',
                          width: 53.0,
                          height: 49.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: contact["gunshot"] == 0? Text(
                          'Gun Sound Not Detected',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 10.0,
                          ),
                        ):Text(
                            'Gun Sound Detected',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              fontSize: 10.0,
                            )
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          const Divider(
            color: Colors.grey,
          ),
          const SizedBox(
            height: 40.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 120.0,
                    height: 40.0,
                    color: Colors.green,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (index == 1) {
                          final GoogleMapController controller =
                              await _controller.future;
                          controller.animateCamera(
                              CameraUpdate.newCameraPosition(source));
                          Navigator.pop(context);
                        } else if (index == 2) {
                          final GoogleMapController controller =
                              await _controller.future;
                          controller.animateCamera(
                              CameraUpdate.newCameraPosition(source_2));
                          Navigator.pop(context);
                        } else if (index == 3) {
                          final GoogleMapController controller =
                              await _controller.future;
                          controller.animateCamera(
                              CameraUpdate.newCameraPosition(source_3));
                          Navigator.pop(context);
                        } else if (index == 4) {
                          final GoogleMapController controller =
                              await _controller.future;
                          controller.animateCamera(
                              CameraUpdate.newCameraPosition(wild));
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        'Locate',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 120.0,
                    height: 40.0,
                    color: Colors.green[200],
                    child: ElevatedButton(
                      onPressed: () async {
                        if (index == 1) {
                          Navigator.pop(context);

                          _getPolyline_2();
                        } else if (index == 2) {
                          Navigator.pop(context);

                          _getPolyline_3();
                        } else if (index == 3) {
                          Navigator.pop(context);

                          _getPolyline_4();
                        }
                      },
                      child: const Text(
                        'Direction',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline_2() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(current.latitude, current.longitude),
        PointLatLng(destination.latitude, destination.longitude),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point_2) {
        polylineCoordinates.add(LatLng(point_2.latitude, point_2.longitude));
      });
    }
    _addPolyLine();
    //Fluttertoast.showToast(msg: 'polyline created',toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.BOTTOM);
  }

  _getPolyline_3() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(current_2.latitude, current_2.longitude),
        PointLatLng(destination.latitude, destination.longitude),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point_2) {
        polylineCoordinates.add(LatLng(point_2.latitude, point_2.longitude));
      });
    }
    _addPolyLine();
    // Fluttertoast.showToast(msg: 'polyline created',toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.BOTTOM);
  }

  _getPolyline_4() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(current_3.latitude, current_3.longitude),
        PointLatLng(destination.latitude, destination.longitude),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point_2) {
        polylineCoordinates.add(LatLng(point_2.latitude, point_2.longitude));
      });
    }
    _addPolyLine();
    // Fluttertoast.showToast(msg: 'polyline created',toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.BOTTOM);
  }

  _getPolyline_5() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(current_4.latitude, current_4.longitude),
        PointLatLng(destination.latitude, destination.longitude),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point_2) {
        polylineCoordinates.add(LatLng(point_2.latitude, point_2.longitude));
      });
    }
    _addPolyLine();
    //Fluttertoast.showToast(msg: 'polyline created',toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.BOTTOM);
  }

  void showMarker() async {
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "images/img.png",
    );
    BitmapDescriptor markerbitmapp = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "images/so.png",
    );
    BitmapDescriptor markerbitmapp3 = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "images/form_2.png",
    );
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('Elephant_10'),
        position: current,
        infoWindow: const InfoWindow(title: 'Elephant one with our device'),
        icon: isstresstrue ? markerbitmap : markerbitmapp,
        onTap: () {

            boundary_1 = checkBoundary(current);

          index = 1;
          showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              builder: (context) => SafeArea(
                      child: Container(
                    height: double.infinity,
                    child: FirebaseAnimatedList(
                      query: ref4,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {

                       // print('Hello..............');
                        //print(snapshot.value);
                        //print(ref4);
                        Map? contact = snapshot.value as Map?;
                        //print('Hello..............$contact');
                        return _buildContactItem(contact: contact);
                      },
                    ),
                  )));
          setState(() {});
        },
        //icon: markerbitmap,
      ));
      _markers.add(Marker(
        markerId: MarkerId('WildLife Ranger'),
        position: destination,
        infoWindow: const InfoWindow(title: 'This is Wildlife guard office'),
        //icon: BitmapDescriptor.defaultMarkerWithHue(90),
        icon: markerbitmapp3,
      ));
      _markers.add(Marker(
        markerId: MarkerId('Firebase__'),
        position: LatLng(current_fb.latitude,current_fb.longitude),
        infoWindow: const InfoWindow(title: 'This is Wildlife guard '),
        icon: BitmapDescriptor.defaultMarkerWithHue(90),
      ));
      _markers.add(Marker(
        markerId: MarkerId('Elephant_11'),
        position: current_2,
        infoWindow: const InfoWindow(title: 'Elephant two with our device'),
        icon: markerbitmap,
        onTap: () {

            boundary_2 = checkBoundary(current_2);

          index = 2;
          showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              builder: (context) => SafeArea(
                      child: Container(
                    height: double.infinity,
                    child: FirebaseAnimatedList(
                      query: ref2,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        Map? contact = snapshot.value as Map?;

                        return _buildContactItem(contact: contact);
                      },
                    ),
                  )));
        },
      ));
      //icon: markerbitmap,);
      _markers.add(Marker(
        markerId: MarkerId('Elephant_12'),
        position: current_3,
        infoWindow: const InfoWindow(title: 'Elephant three with our device'),
        icon: markerbitmap,
        onTap: () {
            boundary_3 = checkBoundary(current_3);

          index = 3;
          showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              builder: (context) => SafeArea(
                      child: Container(
                    height: double.infinity,
                    child: FirebaseAnimatedList(
                      query: ref3,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        Map? contact = snapshot.value as Map?;
                        return _buildContactItem(contact: contact);
                      },
                    ),
                  )));
        },
      ));
      _markers.add(Marker(
        markerId: MarkerId('destinationPin'),
        position: destinationLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(90),
      ));
    });
  }

  intilize() async {
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "images/img.png",
    );
    BitmapDescriptor markerbitmapp = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "images/so.png",
    );
    BitmapDescriptor markerbitmapp3 = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "images/form.png",
    );

    // double latitude = lat;
    // double longitude = lon;
    //  Marker fireMarker = Marker(
    //
    //   markerId: const MarkerId('Elephant 5'),
    //   position:  LatLng( longitude, latitude),
    //
    //  //position:  LatLng(6.89752953462916, 36.646893753526),
    //   infoWindow: const InfoWindow(title: 'This is Elephant is from firebase '),
    //   icon: markerbitmapp,
    //   onTap: () {
    //   },
    // );
    //  Marker wildLifeMarker = Marker(
    //   markerId: const MarkerId('WildLife Ranger'),
    //   //position:  LatLng(lat, lon),
    //   position: const LatLng(6.852953462916, 36.836893753526),
    //   infoWindow: const InfoWindow(title: 'Wildlife Rangers'),
    //   icon: markerbitmapp3,
    //   onTap: () {
    //     index = 1;
    //     showModalBottomSheet(
    //         context: context,
    //         shape: const RoundedRectangleBorder(
    //           borderRadius: BorderRadius.vertical(
    //             top: Radius.circular(20),
    //           ),
    //         ),
    //         builder: (context) => SafeArea(
    //             child: Container(
    //               height: double.infinity,
    //               child: FirebaseAnimatedList(
    //                 query: ref1,
    //                 itemBuilder: (BuildContext context, DataSnapshot snapshot,
    //                     Animation<double> animation, int index) {
    //                   Map? contact = snapshot.value as Map?;
    //                   return _buildContactItem(contact: contact);
    //                 },
    //               ),
    //             )));
    //   },
    // );
    //  Marker firstMarker = Marker(
    //    markerId: const MarkerId('Elephant new'),
    //    //position:  LatLng(lat, lon),
    //   position: const LatLng(6.88752953462916, 36.636893753526),
    //    infoWindow: const InfoWindow(title: 'This is Elephant new '),
    //    icon: markerbitmap,
    //    onTap: () {
    //      index = 1;
    //      showModalBottomSheet(
    //          context: context,
    //          shape: const RoundedRectangleBorder(
    //            borderRadius: BorderRadius.vertical(
    //              top: Radius.circular(20),
    //            ),
    //        ),
    //          builder: (context) => SafeArea(
    //                  child: Container(
    //                height: double.infinity,
    //                child: FirebaseAnimatedList(
    //                  query: ref1,
    //                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
    //                      Animation<double> animation, int index) {
    //                    Map? contact = snapshot.value as Map?;
    //                    return _buildContactItem(contact: contact);
    //                  },
    //                ),
    //              )));
    //    },
    //  );
    //  Marker secondMarker = Marker(
    //   markerId: const MarkerId('Elephant 2'),
    //   position: const LatLng(6.87752953462916, 36.626893753526),
    //   //position: LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude),
    //   infoWindow: const InfoWindow(title: 'This is Elephant two '),
    //   icon: markerbitmap,
    //   onTap: () {
    //     index = 2;
    //     showModalBottomSheet(
    //         context: context,
    //         shape: const RoundedRectangleBorder(
    //           borderRadius: BorderRadius.vertical(
    //             top: Radius.circular(20),
    //           ),
    //         ),
    //         builder: (context) => SafeArea(
    //                 child: Container(
    //               height: double.infinity,
    //               child: FirebaseAnimatedList(
    //                 query: ref2,
    //                 itemBuilder: (BuildContext context, DataSnapshot snapshot,
    //                     Animation<double> animation, int index) {
    //                   Map? contact = snapshot.value as Map?;
    //                   return _buildContactItem(contact: contact);
    //                 },
    //               ),
    //             )));
    //   },
    // );
    //  Marker thirdMarker = Marker(
    //   markerId: const MarkerId('Elephant 3'),
    //  position: const LatLng(6.86752953462916, 36.616893753526),
    //   //position: LatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude),
    //   infoWindow: const InfoWindow(title: 'This is Elephant three '),
    //   icon: markerbitmap,
    //   onTap: () {
    //     index = 3;
    //     showModalBottomSheet(
    //         context: context,
    //         shape: const RoundedRectangleBorder(
    //           borderRadius: BorderRadius.vertical(
    //             top: Radius.circular(20),
    //           ),
    //         ),
    //         builder: (context) => SafeArea(
    //                 child: Container(
    //               height: double.infinity,
    //               child: FirebaseAnimatedList(
    //                 query: ref3,
    //                 itemBuilder: (BuildContext context, DataSnapshot snapshot,
    //                     Animation<double> animation, int index) {
    //                   Map? contact = snapshot.value as Map?;
    //                   return _buildContactItem(contact: contact);
    //                 },
    //               ),
    //             )));
    //   },
    // );
    //  Marker fourthMarker = Marker(
    //   markerId: const MarkerId('Elephant 4'),
    //   position: const LatLng(6.85752953462916, 36.606893753526),
    //   infoWindow: const InfoWindow(title: 'This is Elephant Four '),
    //   icon: markerbitmapp,
    //   onTap: () {
    //     index = 4;
    //     showModalBottomSheet(
    //         context: context,
    //         shape: const RoundedRectangleBorder(
    //           borderRadius: BorderRadius.vertical(
    //             top: Radius.circular(20),
    //           ),
    //         ),
    //         builder: (context) => SafeArea(
    //                 child: Container(
    //               height: double.infinity,
    //               child: FirebaseAnimatedList(
    //                 query: ref4,
    //                 itemBuilder: (BuildContext context, DataSnapshot snapshot,
    //                     Animation<double> animation, int index) {
    //                   Map? contact = snapshot.value as Map?;
    //                   return _buildContactItem(contact: contact);
    //                 },
    //               ),
    //             )));
    //   },
    // );
    // markers.add(firstMarker);
    // markers.add(secondMarker);
    // markers.add(thirdMarker);
    // markers.add(fourthMarker);
    // markers.add(fireMarker);
    // markers.add(wildLifeMarker);

    setState(() {});
  }

  //this is the function to load custom map style json
  void changeMapMode(GoogleMapController mapController) {
    getJsonFile("assets/map_style.json")
        .then((value) => setMapStyle(value, mapController));
  }

  //helper function
  void setMapStyle(String mapStyle, GoogleMapController mapController) {
    mapController.setMapStyle(mapStyle);
  }


  //helper function
  Future<String> getJsonFile(String path) async {
    ByteData byte = await rootBundle.load(path);
    var list = byte.buffer.asUint8List(byte.offsetInBytes, byte.lengthInBytes);
    return utf8.decode(list);
  }

  Future<Position> getcurrentuserdirection() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("error" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }
  loadData(){
  getcurrentuserdirection().then(
          (value)async{
        //Fluttertoast.showToast(msg: 'latitute'+value.latitude.toString()+'lon '+value.longitude.toString(),toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.BOTTOM);
        _markers.add(
            Marker(
              markerId: MarkerId('My_Location'),
              position: LatLng(value.latitude, value.longitude),
              infoWindow: const InfoWindow(title: 'This is your position'),
            )

        );
      });
}
  bool checkBoundary(LatLng currentLocation) {
    bool onRegion = false;
    double x1, x2, x3, x4, y1, y2, y3, y4, xp, yp;

    xp = currentLocation.latitude.toDouble();
    yp = currentLocation.longitude.toDouble();
    x1 = point1.latitude.toDouble();
    y1 = point1.longitude.toDouble();
    x2 = point2.latitude.toDouble();
    y2 = point2.longitude.toDouble();
    x3 = point3.latitude.toDouble();
    y3 = point3.longitude.toDouble();
    x4 = point4.latitude.toDouble();
    y4 = point4.longitude.toDouble();
    double area1 = x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2); //1,2,3
    double area2 = x1 * (y4 - y3) + x4 * (y3 - y1) + x3 * (y1 - y4); // 1,4,3
    double totalArea = (area1.abs() + area2.abs());

    double areaABP = (x1 * (y2 - yp) + x2 * (yp - y1) + xp * (y1 - y2)); //1,2,p
    double areaBCP = (x2 * (y3 - yp) + x3 * (yp - y2) + xp * (y2 - y3)); //2,3,p
    double areaCDP = (x3 * (y4 - yp) + x4 * (yp - y3) + xp * (y3 - y4)); //3,4,p
    double areaDAP = (x4 * (y1 - yp) + x1 * (yp - y4) + xp * (y4 - y1)); //4,1,p


    if ((totalArea).toStringAsFixed(6) ==
        (areaABP.abs() + areaBCP.abs() + areaCDP.abs() + areaDAP.abs())
            .toStringAsFixed(6)) {
      onRegion = true;
    }
    print('Elephant 1 region is on $onRegion');
    if(onRegion) {
      Fluttertoast.showToast(msg: 'This is Elephant is on there GeoFence',
          backgroundColor: Colors.white,
          textColor: Colors.lightGreen,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP);
    }
    else
      {
        Fluttertoast.showToast(msg: 'This is Elephant is out of there GeoFence',
            backgroundColor: Colors.white,
            textColor: Colors.red,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP);
      }
    return onRegion;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: buttontou_
                ? GoogleMap(
                    myLocationEnabled: true,
                    compassEnabled: false,
                    tiltGesturesEnabled: false,
                    //polygons: _polygone,
                    polylines: Set<Polyline>.of(polylines.values),
                    markers: _markers,
                    // mapType: MapType.hybrid,
                    //mapType: MapType.hybrid,
                    // initialCameraPosition: _kGooglePlex,
                    initialCameraPosition: const CameraPosition(
                      target: SOURCE,
                      zoom: 12,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      //controller = _controller;
                      _controller.complete(controller);
                      changeMapMode(controller);

                      showMarker();
                      // _getPolyline();
                    },
                    //markers: markers.map((e) => e).toSet(),
                  )
                : GoogleMap(
                    myLocationEnabled: true,
                    compassEnabled: false,
                    tiltGesturesEnabled: false,
                    polygons: _polygone,
                    polylines: Set<Polyline>.of(polylines.values),
                    markers: _markers,
                    mapType: MapType.hybrid,
                    //mapType: MapType.hybrid,
                    // initialCameraPosition: _kGooglePlex,
                    initialCameraPosition: const CameraPosition(
                      target: SOURCE,
                      zoom: 12,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      //controller = _controller;
                      _controller.complete(controller);
                      //changeMapMode(controller);

                      showMarker();
                      // _getPolyline();
                    },
                    //markers: markers.map((e) => e).toSet(),
                  ),
          ),
          Positioned(
            bottom: 180,
            width: 60,
            height: 140,
            right: 10,
            child: Container(
              height: 70.0,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          elevation: MaterialStateProperty.all(0.0),
                          shadowColor: MaterialStateProperty.all(
                            Colors.transparent,
                          )),
                      onPressed: () {
                        // polylineCoordinates.clear();
                        // buttontou_ = true;
                        // isstresstrue = false;
                        isstresstrue = false;
                        String be = isstresstrue.toString();

                        //Fluttertoast.showToast(msg: 'Elephant 1 stress detected!'+be+'sas',backgroundColor: Colors.white,textColor: Colors.red,toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.TOP);

                        polylineCoordinates.clear();
                        if (_stress1 == 1 && _stress2 == 1 && _stress3 == 1) {
                          Fluttertoast.showToast(
                              msg:
                              'Elephant 1 stress detected! \nElephant 2 stress detected!\nElephant 3 stress detected!',
                              backgroundColor: Colors.white,
                              textColor: Colors.red,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP);
                        } else if (_stress1 == 1 && _stress2 == 1) {
                          Fluttertoast.showToast(
                              msg:
                              'Elephant 1 stress detected! \nElephant 2 stress detected!',
                              backgroundColor: Colors.white,
                              textColor: Colors.red,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP);
                        } else {
                          if (_stress1 == 1 && _stress3 == 1) {
                          Fluttertoast.showToast(
                              msg:
                              'Elephant 1 stress detected! \nElephant 3 stress detected!',
                              backgroundColor: Colors.white,
                              textColor: Colors.red,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP);
                        } else if (_stress3 == 1 && _stress2 == 1) {
                          Fluttertoast.showToast(
                              msg:
                              'Elephant 2 stress detected! \nElephant 3 stress detected!',
                              backgroundColor: Colors.white,
                              textColor: Colors.red,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP);
                        } else if (_stress1 == 1) {
                          Fluttertoast.showToast(
                              msg: 'Elephant 1 stress detected!',
                              backgroundColor: Colors.white,
                              textColor: Colors.red,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP);
                        } else if (_stress2 == 1) {
                          Fluttertoast.showToast(
                              msg: 'Elephant 2 stress detected!',
                              backgroundColor: Colors.white,
                              textColor: Colors.red,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP);
                        } else if (_stress1 == 1) {
                          Fluttertoast.showToast(
                              msg: 'Elephant 3 stress detected!',
                              backgroundColor: Colors.white,
                              textColor: Colors.red,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP);
                        } else {
                          Fluttertoast.showToast(
                              msg: 'No stress Sound Detected',
                              backgroundColor: Colors.white,
                              textColor: Colors.red,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP);
                        }
                        }
                        setState(() {
                          // changeMapMode(controller);

                          clicks = !clicks;
                          clicks_2 = true;
                          clicks_3 = true;
                          clicks_4 = true;
                          clicks_5 = true;
                        });
                      },
                      child: Icon(Icons.notifications_active_rounded,
                          size: 35,
                          color:
                              (clicks) ?  Color(0xff0a0a0a):Color(0xffff1616)),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        elevation: MaterialStateProperty.all(0.0),
                        shadowColor: MaterialStateProperty.all(
                          Colors.transparent,
                        )),
                    onPressed: () {
                      //  polylineCoordinates.clear();
                      buttontou_ = false;

                      Fluttertoast.showToast(
                          msg:
                              'The green line indicate the geofence of the park',
                          backgroundColor: Colors.white,
                          textColor: Colors.lightGreen,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP);

                      setState(() {
                        clicks_2 = !clicks_2;
                        clicks = true;
                        clicks_3 = true;
                        clicks_4 = true;
                        clicks_5 = true;
                      });
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> alerts()));
                    },
                    child: Icon(Icons.map_sharp,
                        size: 35,
                        color:
                            (clicks_2) ? Color(0xff0a0a0a) : Color(0xff5be256)),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 65,
            right: 65,
            child: Center(
              child: Container(
                height: 70.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Center(
                    child: Row(
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              elevation: MaterialStateProperty.all(0.0),
                              shadowColor: MaterialStateProperty.all(
                                Colors.transparent,
                              )),
                          onPressed: () {
                            //Fluttertoast.showToast(msg: 'la '+lat.toString()+'lo'+lon.toString(),backgroundColor: Colors.white,textColor: Colors.red,toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.TOP);

                            polylineCoordinates.clear();
                            buttontou_ = true;
                            isstresstrue = false;
                            //
                            // isstresstrue = false;
                            // String be = isstresstrue.toString();
                            //
                            // //Fluttertoast.showToast(msg: 'Elephant 1 stress detected!'+be+'sas',backgroundColor: Colors.white,textColor: Colors.red,toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.TOP);
                            //
                            // polylineCoordinates.clear();
                            // if (stress == 1 && stress_2 == 1 && stress_3 == 1) {
                            //   Fluttertoast.showToast(
                            //       msg:
                            //           'Elephant 1 stress detected! \nElephant 2 stress detected!\nElephant 3 stress detected!',
                            //       backgroundColor: Colors.white,
                            //       textColor: Colors.red,
                            //       toastLength: Toast.LENGTH_SHORT,
                            //       gravity: ToastGravity.TOP);
                            // } else if (stress == 1 && stress_2 == 1) {
                            //   Fluttertoast.showToast(
                            //       msg:
                            //           'Elephant 1 stress detected! \nElephant 2 stress detected!',
                            //       backgroundColor: Colors.white,
                            //       textColor: Colors.red,
                            //       toastLength: Toast.LENGTH_SHORT,
                            //       gravity: ToastGravity.TOP);
                            // } else if (stress == 1 && stress_3 == 1) {
                            //   Fluttertoast.showToast(
                            //       msg:
                            //           'Elephant 1 stress detected! \nElephant 3 stress detected!',
                            //       backgroundColor: Colors.white,
                            //       textColor: Colors.red,
                            //       toastLength: Toast.LENGTH_SHORT,
                            //       gravity: ToastGravity.TOP);
                            // } else if (stress_3 == 1 && stress_2 == 1) {
                            //   Fluttertoast.showToast(
                            //       msg:
                            //           'Elephant 2 stress detected! \nElephant 3 stress detected!',
                            //       backgroundColor: Colors.white,
                            //       textColor: Colors.red,
                            //       toastLength: Toast.LENGTH_SHORT,
                            //       gravity: ToastGravity.TOP);
                            // } else if (stress == 1) {
                            //   Fluttertoast.showToast(
                            //       msg: 'Elephant 1 stress detected!',
                            //       backgroundColor: Colors.white,
                            //       textColor: Colors.red,
                            //       toastLength: Toast.LENGTH_SHORT,
                            //       gravity: ToastGravity.TOP);
                            // } else if (stress == 2) {
                            //   Fluttertoast.showToast(
                            //       msg: 'Elephant 2 stress detected!',
                            //       backgroundColor: Colors.white,
                            //       textColor: Colors.red,
                            //       toastLength: Toast.LENGTH_SHORT,
                            //       gravity: ToastGravity.TOP);
                            // } else if (stress == 3) {
                            //   Fluttertoast.showToast(
                            //       msg: 'Elephant 3 stress detected!',
                            //       backgroundColor: Colors.white,
                            //       textColor: Colors.red,
                            //       toastLength: Toast.LENGTH_SHORT,
                            //       gravity: ToastGravity.TOP);
                            // } else {
                            //   Fluttertoast.showToast(
                            //       msg: 'No stress Sound Detected',
                            //       backgroundColor: Colors.white,
                            //       textColor: Colors.red,
                            //       toastLength: Toast.LENGTH_SHORT,
                            //       gravity: ToastGravity.TOP);
                            // }

                            setState(() {
                              clicks_3 = !clicks_3;
                              clicks_2 = true;
                              clicks = true;
                              clicks_4 = true;
                              clicks_5 = true;
                            });
                          },
                          child: Icon(Icons.location_on_outlined,
                              size: 35,
                              color: (clicks_3)
                              ? Color(0xff0a0a0a) : Color(0xff5be256)),

                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              elevation: MaterialStateProperty.all(0.0),
                              shadowColor: MaterialStateProperty.all(
                                Colors.transparent,
                              )),
                          onPressed: () {
                            polylineCoordinates.clear();
                            setState(() {
                              clicks_4 = !clicks_4;
                              clicks_2 = true;
                              clicks_3 = true;
                              clicks_5 = true;
                              clicks = true;
                            });
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => alerts()));
                          },
                          child: Icon(Icons.warning,
                              size: 35,
                              color: (clicks_4)
                                  ? Color(0xff0a0a0a)
                                  : Color(0xff5be256)),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              elevation: MaterialStateProperty.all(0.0),
                              shadowColor: MaterialStateProperty.all(
                                Colors.transparent,
                              )),
                          onPressed: () {
                            polylineCoordinates.clear();
                            setState(() {
                              clicks_5 = !clicks_5;
                              clicks_4 = true;
                              clicks_2 = true;
                              clicks_3 = true;
                              clicks = true;
                            });
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => setting()));
                          },
                          child: Icon(Icons.settings,
                              size: 35,
                              color: (clicks_5)
                                  ? Color(0xff0a0a0a)
                                  : Color(0xff5be256)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //     child: const Icon(Icons.location_on,
      //       size: 35,
      //     color: Colors.grey,
      //     ),
      //     onPressed: () {
      //
      //
      // }),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

import 'dart:async';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  State<MapSample> createState() => MapSampleState();
}
class MapSampleState extends State<MapSample> {
  final fb = FirebaseDatabase.instance;
  late Query ref1;
  late Query ref2;

  
  // late final dref = FirebaseDatabase.instance.reference();
  //  late DatabaseReference databaseReference;

  //
  // setData(){
  //   dref.child("info").set(
  //     {
  //     'id':"01",
  //       'name':'Betemariam',
  //     }
  //   );
  // }
  // showData(){
  //   DataSnapshot snapshot;
  //   dref.child('info').once().then((snapshot)
  //   {
  //     print(snapshot.snapshot.value);
  //
  //   });
  // }
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers = [];


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

  @override
  void initState() {
    ref1 = fb.ref().child('Contacts');
    ref2 = fb.ref().child('test');
    intilize();
   // databaseReference = dref.child('Elephant 1');
    super.initState();
  }
  Widget _buildContactItem({ Map? contact}){
   return Container(
     height: 100,
     color: Colors.white,
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Icon(Icons.person,
         color: Theme.of(context).primaryColor,
         size: 20,
         ),
         SizedBox(width: 6,),
         Text(contact!["name"],style: TextStyle(
         color: Theme.of(context).primaryColor,
         fontWeight: FontWeight.w600,
         ),),


       ],

     ),

   );
  }

  intilize() async {
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "images/img.png",
    );
    BitmapDescriptor markerbitmapp = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "images/so.png",
    );
    Marker firstMarker = Marker(markerId: MarkerId('Elephant 1'),
    position: LatLng(6.88752953462916, 36.636893753526),
      infoWindow: InfoWindow(title: 'This is Elephant one '),
      icon:markerbitmap,
      onTap: ()  {
        showModalBottomSheet(context: context, shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20),),

        ),
            builder:(context) => SafeArea(
              child: Column(
               // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(

                    children: <Widget>[

                     Container(
                       margin: EdgeInsets.all(15),
                       padding: EdgeInsets.only(left: 25.0,right: 25.0),
                       child: Icon(
                          Icons.warning,
                          color: Colors.red,
                          size: 35,
                        ),
                     ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        'Elephant Status',style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      ),
                      ),
                    ],
                  ),

                  Divider(
                    color: Colors.grey,
                  ),
                  Container(
                    child: Row(

                      children: <Widget>[

                        Container(
                          width: 90,
                          height: 90,
                          margin: EdgeInsets.only(left: 25.0),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                         child: Center(
                           // child: FirebaseAnimatedList(query: databaseReference,itemBuilder: (BuildContext context,DataSnapshot snapshot , Animation animation, int index  ) {
                           //   //var name='name';
                           //  // dynamic docData = snapshot.value['Heart Beat'];
                           //
                           //   return Text(snapshot.value!['Heart Beat']);
                           // }),
                           // child: Text('30 BPM',style: TextStyle(
                           //   fontWeight: FontWeight.bold,
                           //     color: Colors. red,
                           //   fontSize: 15.0,
                           // ),
                           //
                           // ),
                         ),
                        ),
                        SizedBox(
                          width: 100,
                        ),
                       Expanded(
                         child: Column(
                           children: [
                             Image.asset('images/stress.png',
                               width: 53.0,
                               height: 49.0,
                             ),
                             SizedBox(height: 10,),
                             Center(child: Text('Stress Sound Not Detected')),

                           ],
                         ),
                       )
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    width: 150.0,
                    height: 50.0,
                    color: Colors.green,
                    child: ElevatedButton(onPressed: () async {

                      final GoogleMapController controller = await _controller.future;
                      controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
                      Navigator.pop(context);

                    },
                        child: Text('Locate',style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                        ),
                    ),
                  ),
                ],


              ),


            )
        );
      },

    );
    Marker secondMarker = Marker(markerId: MarkerId('Elephant 2'),
      position: LatLng(6.87752953462916, 36.626893753526),
      infoWindow: InfoWindow(title: 'This is Elephant two '),
      icon:markerbitmap,
      onTap: ()  {
        showModalBottomSheet(context: context, shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20),),

        ),
            builder:(context) => SafeArea(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(

                    children: <Widget>[

                      Container(
                        height: double.infinity,
                        child: FirebaseAnimatedList(query: ref1 ,itemBuilder:(BuildContext context,
                            DataSnapshot snapshot,Animation<double>animation, int index){
                          Map? contact = snapshot.value as Map?;
                          return _buildContactItem(contact: contact);
                        } ,),

                  ),
                ],


              ),



      ]
        )
        )
        );
      },
    );
    Marker thirdMarker = Marker(markerId: MarkerId('Elephant 3'),
      position: LatLng(6.86752953462916, 36.616893753526),
      infoWindow: InfoWindow(title: 'This is Elephant three '),
      icon:markerbitmap,
      onTap: ()  {
        showModalBottomSheet(context: context, shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20),),

        ),
            builder:(context) => SafeArea(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(

                    children: <Widget>[

                      Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.only(left: 25.0,right: 25.0),
                        child: Icon(
                          Icons.warning,
                          color: Colors.red,
                          size: 35,
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        'Elephant Status',style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      ),
                      ),
                    ],
                  ),

                  Divider(
                    color: Colors.grey,
                  ),
                  Container(
                    child: Row(

                      children: <Widget>[

                        Container(
                          width: 90,
                          height: 90,
                          margin: EdgeInsets.only(left: 25.0),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text('30 BPM',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors. red,
                              fontSize: 15.0,
                            ),

                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Image.asset('images/stress.png',
                                width: 53.0,
                                height: 49.0,
                              ),
                              SizedBox(height: 10,),
                              Center(child: Text('Stress Sound Not Detected')),

                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    width: 150.0,
                    height: 50.0,
                    color: Colors.green,
                    child: ElevatedButton(onPressed: () async {

                      final GoogleMapController controller = await _controller.future;
                      controller.animateCamera(CameraUpdate.newCameraPosition(_kLake_3));
                      Navigator.pop(context);

                    },
                      child: Text('Locate',style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                      ),
                    ),
                  ),
                ],


              ),


            )
        );
      },


    );
    Marker fourthMarker = Marker(markerId: MarkerId('Elephant 4'),
      position: LatLng(6.85752953462916, 36.606893753526),
      infoWindow: InfoWindow(title: 'This is Elephant Four '),
      icon:markerbitmapp,
      onTap: ()  {
        showModalBottomSheet(context: context, shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20),),

        ),
            builder:(context) => SafeArea(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(

                    children: <Widget>[

                      Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.only(left: 25.0,right: 25.0),
                        child: Icon(
                          Icons.warning,
                          color: Colors.red,
                          size: 35,
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        'Elephant Status',style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                      ),
                    ],
                  ),

                  Divider(
                    color: Colors.grey,
                  ),
                  Container(
                    child: Row(

                      children: <Widget>[

                        Container(
                          width: 90,
                          height: 90,
                          margin: EdgeInsets.only(left: 25.0),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text('30 BPM',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors. red,
                              fontSize: 15.0,
                            ),

                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Image.asset('images/stress.png',
                                width: 53.0,
                                height: 49.0,
                              ),
                              SizedBox(height: 10,),
                              Center(child: Text('Stress Sound Detected')),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    width: 150.0,
                    height: 50.0,
                    color: Colors.green,
                    child: ElevatedButton(onPressed: () async {

                      final GoogleMapController controller = await _controller.future;
                      controller.animateCamera(CameraUpdate.newCameraPosition(_kLake_4));
                      Navigator.pop(context);

                    },
                      child: Text('Locate',style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                      ),
                    ),
                  ),
                ],


              ),


            )
        );
      },


    );
    markers.add(firstMarker);
    markers.add(secondMarker);
    markers.add(thirdMarker);
    markers.add(fourthMarker);

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers.map((e) => e).toSet(),
      ),

      floatingActionButton:
    FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('Locate the Elephant'),
        icon: Icon(Icons.directions_boat),
    // FloatingActionButton(
    // onPressed: be,
    // tooltip: 'Increment',
    // child: const Icon(Icons.add),
      ),


    );
  }

  Future<void> _goToTheLake() async {
    // final GoogleMapController controller = await _controller.future;
    // controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));

  }
}

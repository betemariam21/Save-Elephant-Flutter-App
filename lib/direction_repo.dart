import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:save_elephants/.env.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Direction_Repo{
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json';
 // final Dio _dio;
//   Direction_Repo({required Dio dio}) : _dio = dio ?? Dio();
//
//   Future<Directions> getDirections({
//   required LatLng origin,
//   required LatLng destination,
// }) async{
//     final response = await _dio.get(
//       _baseUrl,
//       queryParameters:{
//         'origin':'12.211111,21.211111',
//         'destination':'12.2111111,12.211111111',
//         'key': googleAPIKey,
//       },
//     );
//     if(response.statusCode == 200)
//       {
//         return Directions.fromMap(response.data);
//       }
//       return null;
//
//   }
}
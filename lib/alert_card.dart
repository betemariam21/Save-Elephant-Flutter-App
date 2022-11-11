import 'package:flutter/material.dart';
import 'map_s.dart';
class alert_card extends StatelessWidget {
  final List _stress = ['Elephant 2','Elephant 2','Elephant 3'];
  final List _time = ['7:30','7:00','8:00'];
  @override
  Widget build(BuildContext context) {
    return  Padding(padding: EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        //color: Colors.white,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.white38,
          ),
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
       child: Row(
         children:  <Widget>[
           SizedBox(width: 10,),
           Icon(
             Icons.warning_amber_outlined,
             color: Colors.red,
             size: 35,
           ),
          // SizedBox(width: 1,),
           VerticalDivider(
             width: 20,
             indent: 15,
            endIndent: 15,
            // thickness: 2,
             color: Colors.grey,
           ),
           SizedBox(width: 3,),
           Column(

             children: [
               SizedBox(height: 11,),
               Text(
                 _stress[0],style: TextStyle(
                 fontWeight: FontWeight.bold
               ),
               ),
               SizedBox(
                 height: 10.0,
               ),
               Row(
                 children: [

                   Text('Type:',
                     style: TextStyle(
                       fontWeight: FontWeight.bold,
                     ),),
                   SizedBox(
                     width: 105.0,
                   ),
                   Text('Time:',
                     style: TextStyle(
                       fontWeight: FontWeight.bold,
                     ),),
                 ],
               ),
               SizedBox(
                 height: 5.0,
               ),
               Row(
                 children: [

                   Text('Geo-fence',
                     style: TextStyle(
                       fontWeight: FontWeight.normal,
                     ),),
                   SizedBox(
                     width: 80.0,
                   ),
                   Text(_time[0],
                     style: TextStyle(
                       fontWeight: FontWeight.normal,
                     ),),
                 ],
               ),
             ],

           ),
         ],


       ),
      ),

    );

  }
}

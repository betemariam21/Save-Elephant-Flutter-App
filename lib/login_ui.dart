import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:save_elephants/maps.dart';
import 'package:save_elephants/profile_Screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:save_elephants/test.dart';

import 'map_s.dart';
import 'new_map.dart';

class login_ui extends StatefulWidget {
  const login_ui({Key? key}) : super(key: key);
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login_ui> {
  bool isLoading = false;
  late final dref = FirebaseDatabase.instance.reference();
  late DatabaseReference databaseReference;
  double width = double.infinity;

  setData(){
    dref.child("info").set(
        {
          'id':"01",
          'name':'Betemariam',
        }
    );

  }
  //Initialiaze Firebase
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }
  static Future<User?> loginUsingEmailPassword({required String email, required String password, required BuildContext context}) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential =await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
       }
  on FirebaseException catch (e)
  {
   if(e.code=='user-not-found')
   {
   print('No user found');
   }
  }
return user;
}
  @override
  Widget build(BuildContext context) {

    int i = 0;
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset : false,
      body:
      Padding(
        padding: const EdgeInsets.all(25.0),
        
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Image.asset(
                  'images/se.png',
                  height: 100.0,
                  width: 150.0,
                ),
                const Text('Please enter your login credential',style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal,

                ),),
                const  SizedBox(
                  height: 40.0,
                ),
                 TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: "email",
                    prefixIcon: Icon(Icons.email,color: Colors.grey,),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green,width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.5),
                    ),
                  ),
                ),
                const  SizedBox(
                  height: 20.0,
                ),
                 TextField(
                  //keyboardType: TextInputType.visiblePassword,
                  controller: _passwordController,
                  obscureText: true,
                  decoration:  const InputDecoration(
                    hintText: "password",
                    prefixIcon: Icon(Icons.lock,color: Colors.grey,),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green,width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.5),
                    ),
                  ),

                ),
                const SizedBox(height: 40.0,),
               Container(

                  //width: double.infinity,
                 //width: 100.0,
                 width: width,
                  child: RawMaterialButton(
                    fillColor: const Color(0xFF90EE90),
                    elevation: 0.0,
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    onPressed: () async {
                    //  setState(() {
                         // isLoading = true;
                         // width = 30;
                      //  });
                      User? user = await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);
                      if(user != null){
                        //show_toast_2();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> map_s()));
                       //  setState(() {
                         //  isLoading = false;
                           //width = double.infinity;
                         // });
                      }
                      else
                      {
                        show_toast();
                       //  setState(() {
                           //isLoading = false;
                           //width = double.infinity;
                        // });
                      }
                    },

                    child: isLoading? CircularProgressIndicator(
                      color: Colors.white,
                    ):Text("Login",style:
                    TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),),
                  ),
                ),
                const  SizedBox(
                  height: 16.0,
                ),
                const Text('Please contact your administrator if you forget your password.',style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,),
                ),
                const  SizedBox(
                  height: 16.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    //color: Colors.red,
                  ),
                  width: double.infinity,
                  child: RawMaterialButton(

                    fillColor: const Color(0xFFffffff),
                    elevation: 0.0,
                    padding: EdgeInsets.symmetric(vertical: 15.0),

                    child: const Text("Request for new password",style:
                    TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),),

                    onPressed: () {
                      show_toast_2();

                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> map_s()));
                    },

                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
            const Visibility(

              visible: false,

                 child: CircularProgressIndicator(

                  ),
               ),


              ],
            ),
          ),
        ),
      ),

    );


  }
}
void show_toast(){
  //print('we are at show toast');
  Fluttertoast.showToast(msg: 'this account doesnt exist please enter your given credential ',toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.BOTTOM);
  //print('out of show toast');

  }
void show_toast_2(){
  //print('we are at show toast');
  Fluttertoast.showToast(msg: 'Your request is send to your Administrator ',toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM);
  //print('out of show toast');

}
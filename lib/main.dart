import 'package:assignment/dashboard.dart';
import 'package:assignment/registration.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
   MyApp({super.key});
     final Future<FirebaseApp> _initialization=Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
       home:FutureBuilder(future: _initialization,
      builder: (context,snapshot){
        if(snapshot.hasError){
          print("error");
        }if(snapshot.connectionState ==ConnectionState.done){
          return RegistrationPage();
        }return CircularProgressIndicator();
      

      },),);
  }
}



  
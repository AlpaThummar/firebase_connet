
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_connet/second_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';



Future<void> main() async {  //Initialization flutterfire#
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     );


  runApp(MaterialApp(home: google_login(),));
}


class google_login extends StatefulWidget {
  const google_login({Key? key}) : super(key: key);




  @override
  State<google_login> createState() => _google_loginState();
}

class _google_loginState extends State<google_login> {


  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Name, email address, and profile photo URL
      String name = user.displayName.toString();
      String email = user.email.toString();
      // final photoUrl = user.photoURL;
      //
      // // Check if user's email is verified
      // String emailVerified = user.emailVerified.toString();
      //
      // // The user's ID, unique to the Firebase project. Do NOT use this value to
      // // authenticate with your backend server, if you have one. Use
      // // User.getIdToken() instead.
      // String uid = user.uid;


      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return second_page(name, email);
        },));

      });



    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google Login"),),
      body:
      Center(
        child: ElevatedButton(onPressed: () {
          signInWithGoogle().then((value) {
            print(value);
            String name,email;
            name=value.user!.displayName.toString();
            email=value.user!.email.toString();
            //
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return second_page(name,email);
            // },));
          });

        }, child: Text("google_login")),
      ),
    );
  }
}

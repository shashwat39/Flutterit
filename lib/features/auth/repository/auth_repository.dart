import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reddit_clone/core/providers/firebase_providers.dart';
import 'package:reddit_clone/models/user_model.dart';

import '../../../core/constants/constants.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(firestore: ref.read(firestoreProvider),
 auth: ref.read(authProvider),
  googleSignIn: ref.read(googleSignInProvider)));


class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({required FirebaseFirestore firestore,
   required FirebaseAuth auth, 
   required GoogleSignIn googleSignIn
   }): _auth = auth,
    _firestore = firestore,
    _googleSignIn = googleSignIn;


    void signInWithGoogle() async {
      try{
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser?.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        UserCredential userCredential = await _auth.signInWithCredential(credential);

        UserModel userModel = UserModel(name: UserCredential.user!.displayName??'No Name', profilePic: UserCredential.user!.photoURL??Constants.avatarDefault, banner: banner, uid: uid, isAuthenticated: isAuthenticated, karma: karma, awards: awards)
      }
      catch (e) {
        print(e);
      }
    }


}
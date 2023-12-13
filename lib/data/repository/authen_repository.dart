import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_nd/data/repository/authen_repos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepository {
  final AuthService _authService;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; 

  AuthRepository(this._authService);

  Future<void> signIn(String email, String password) async {
    await _authService.signInWithEmailAndPassword(email, password);
  }

  Future<void> signUp(String email, String password, String name, String phone, String country) async {
    UserCredential userCredential = await _authService.createUserWithEmailAndPassword(email, password);
    
 
    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'name': name,
      'phone': phone,
      'country': country
    });
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }

  User? get currentUser => _authService.currentUser;
}
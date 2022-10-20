import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserService {
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> setUser(UserModel user) async {
    try {
      _userReference.doc(user.id).set({
        'email': user.email,
        'name': user.name,
        'gender': user.gender,
        'date_of_birth': user.dateOfBirth,
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> getUserById(String id) async {
    try {
      DocumentSnapshot snapshot = await _userReference.doc(id).get();
      return UserModel(
        id: id,
        email: snapshot['email'],
        name: snapshot['name'],
        gender: snapshot['gender'],
        dateOfBirth: snapshot['date_of_birth'],
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> updateUser(
      {required String label,
      required String value,
      required String userId}) async {
    try {
      _userReference.doc(userId).update({
        label: value,
      });
      UserModel user = await getUserById(userId);
      return user;
    } catch (e) {
      throw Exception(e);
    }
  }
}

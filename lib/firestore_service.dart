import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Method to get user data by token
  Future<Map<String, dynamic>?> getUserDataByToken(String token) async {
    try {
      // Query the users collection for a document where the token matches
      var querySnapshot = await _db.collection('users').where('token', isEqualTo: token).get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.data();
      }
    } catch (e) {
      print('Error fetching user data by token: $e');
    }
    return null;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // دالة لجلب بيانات المستخدم باستخدام uid
  Future<Map<String, dynamic>?> getUserDataByUid(String uid) async {
    try {
      // الوصول إلى مجموعة 'users' في Firestore
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();

      if (userDoc.exists) {
        // تحويل البيانات إلى Map إذا كانت الوثيقة موجودة
        return userDoc.data() as Map<String, dynamic>;
      } else {
        print('User data not found for UID: $uid');
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }
}

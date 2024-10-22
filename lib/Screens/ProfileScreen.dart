import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_trial/Screens/get_start_screen.dart';

import '../firestore_service.dart';
import 'SignUp.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  FirestoreService firestoreService = FirestoreService();
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // استدعاء الدالة عند بداية تشغيل الـ Widget
  }

  Future<void> _fetchUserData() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid; // الحصول على uid
    if (uid != null) {
      var data = await firestoreService
          .getUserDataByUid(uid); // جلب البيانات باستخدام uid
      setState(() {
        userData = data;
      });
    } else {
      print('User is not logged in. Cannot retrieve uid.');
    }
  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => AuthScreen()));
      print("User loged out");
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: userData == null
          ? const Center(
              child:
                  CircularProgressIndicator(), // إذا كانت البيانات غير موجودة، نعرض مؤشر تحميل
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(),
                  _buildBody(context),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue.shade400, Colors.blue.shade800],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userData?['name'] ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  userData?['email'] ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 35,
            left: 20,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 47,
                foregroundColor: Colors.white,
                foregroundImage: AssetImage(
                  (userData != null && userData?['profilePicture'] != null)
                      ? '${userData?['profilePicture']}'
                      : 'assets/empty profile.jpeg', // استخدام صورة افتراضية في حال عدم وجود صورة للمستخدم
                ),
              ),
            ),
          ),
          Positioned(
              top: 50,
              right: 20,
              child: IconButton(
                  onPressed: () {
                    _signOut();
                  },
                  icon: Icon(
                    Icons.logout_outlined,
                    size: 30,
                  )))
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('User Data'),
          _buildInfoGrid(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
        width: double.infinity,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ));
  }

  Widget _buildInfoGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      children: [
        _buildInfoItem(Icons.cake, 'Age', '${userData?['age'] ?? 0} years'),
        _buildInfoItem(Icons.height, 'Height',
            '${(userData?['height'] ?? 0).toStringAsFixed(1)} cm'),
        _buildInfoItem(Icons.monitor_weight, 'Weight',
            '${(userData?['weight'] ?? 0).toStringAsFixed(1)} kg'),
        _buildInfoItem(
            Icons.person, 'Gender', '${userData?['gender'] ?? 'N/A'}'),
        // عرض النص مباشرةً بدون toStringAsFixed
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 300, // تحديد ارتفاع العنصر
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.blue, size: 50), // تعديل حجم الأيقونة
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

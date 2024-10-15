import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();

    if (token != null) {
      var data = await firestoreService.getUserDataByToken(token);
      setState(() {
        userData = data;
      });
    } else {
      print('User is not logged in. Cannot retrieve token.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userData == null
          ? const Center(
          child: CircularProgressIndicator()) // إذا كانت البيانات غير موجودة، نعرض مؤشر تحميل
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
      height: 200,
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
            top: 20,
            left: 20,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 47,
                backgroundImage: AssetImage(
                  userData != null && userData?['profilePicture'] != null
                      ? 'assets/${userData?['profilePicture']}'
                      : 'assets/woman.png', // استخدام صورة افتراضية في حال عدم وجود صورة للمستخدم
                ),

              ),
            ),
          ),
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

          _buildSectionTitle('user data'),
          const SizedBox(height: 10),
          _buildInfoGrid(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildProgressBar(BuildContext context, double progress, int current,
      double goal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 15,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              progress >= 1 ? Colors.green : Colors.blue,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          "$current / ${goal.toStringAsFixed(0)} hours",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: progress >= 1 ? Colors.green : Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.5,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      children: [
        _buildInfoItem(Icons.cake, 'العمر', '${userData?['age'] ?? 0} years'),
        _buildInfoItem(Icons.height, 'الطول',
            '${(userData?['height'] ?? 0).toStringAsFixed(1)} cm'),
        _buildInfoItem(Icons.monitor_weight, 'الوزن',
            '${(userData?['weight'] ?? 0).toStringAsFixed(1)} kg'),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 100, // تحديد ارتفاع العنصر
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
          Icon(icon, color: Colors.blue, size: 30), // تعديل حجم الأيقونة
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

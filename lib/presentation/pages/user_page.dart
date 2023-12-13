import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nd/generated/locale_keys.g.dart';
import 'package:flutter_nd/presentation/blocs/authen_bloc/authen_bloc.dart';
import 'package:flutter_nd/presentation/blocs/authen_bloc/authen_event.dart';
import 'package:flutter_nd/presentation/pages/color.dart';
import 'package:flutter_nd/presentation/pages/lang.dart';
import 'package:flutter_nd/presentation/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _imagePath = prefs.getString('profile_image');
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image', pickedFile.path);

      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorColors.color12,
        title: Text(LocaleKeys.Profile.tr()),
        leading: Icon(Icons.person),
        actions: [
            Language(),
          ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            userId == null
                ? Center(child: Text('Пользователь не вошел в систему'))
                : StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance.collection('users').doc(userId).snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (!snapshot.hasData || snapshot.data!.data() == null) {
                        return Text("Данные пользователя отсутствуют");
                      }
                      var userData = snapshot.data!.data() as Map<String, dynamic>;
                      return Column(
                        children: <Widget>[
                          if (_imagePath != null)
                            SizedBox(
                              width: 200, 
                              height: 200,
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                child: Image.network(_imagePath!, fit: BoxFit.cover),
                              ),
                            ),
                          SizedBox(height: 20),
                          _userInfoCard(LocaleKeys.name.tr(), userData['name'] ?? 'Неизвестно'),
                          _userInfoCard(LocaleKeys.phone.tr(), userData['phone'] ?? 'Неизвестно'),
                          _userInfoCard(LocaleKeys.country.tr(), userData['country'] ?? 'Неизвестно'),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorColors.primaryColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                            ),
                            onPressed: _pickImage,
                            child: Text(LocaleKeys.change.tr()),
                          ),
                          SizedBox(height: 20), 
                          _buildCard(LocaleKeys.My_purchases.tr(), Icons.shopping_bag, () {}),
                          _buildCard(LocaleKeys.My_Wallet.tr(), Icons.account_balance_wallet, () {}),
                          _buildCard(LocaleKeys.my_basket.tr(), Icons.shopping_cart, () {}),
                          SizedBox(height: 20), 
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorColors.primaryColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                            ),
                            onPressed: () {
                              BlocProvider.of<AuthBloc>(context).add(SignOutRequested());
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
                            },
                            child: Text(LocaleKeys.Logout.tr()),
                          ),
                        ],
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Widget _userInfoCard(String title, String data) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 5,
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text(data),
      ),
    );
  }

  Widget _buildCard(String title, IconData icon, VoidCallback onPressed) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 5,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: onPressed,
      ),
    );
  }
}
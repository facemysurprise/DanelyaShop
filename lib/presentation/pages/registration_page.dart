import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nd/generated/locale_keys.g.dart';
import 'package:flutter_nd/presentation/blocs/authen_bloc/authen_bloc.dart';
import 'package:flutter_nd/presentation/blocs/authen_bloc/authen_event.dart';
import 'package:flutter_nd/presentation/pages/color.dart';

class RegistrationPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Registration.tr()),
        backgroundColor: ColorColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              _buildTextField(_nameController, LocaleKeys.name.tr(), Icons.person),
              _buildTextField(_phoneController, LocaleKeys.phone.tr(), Icons.phone),
              _buildTextField(_countryController, LocaleKeys.country.tr(), Icons.map),
              _buildTextField(_emailController, LocaleKeys.Email.tr(), Icons.email),
              _buildTextField(_passwordController, LocaleKeys.Password.tr(), Icons.lock, isPassword: true),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(
                    SignUpRequested(
                      _emailController.text,
                      _passwordController.text,
                      _nameController.text,
                      _phoneController.text,
                      _countryController.text,
                    ),
                  );
                },
                child: Text(LocaleKeys.Signup.tr()),
                style: ElevatedButton.styleFrom(backgroundColor: ColorColors.primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: ColorColors.primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: ColorColors.primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: ColorColors.color12),
          ),
        ),
      ),
    );
  }
}
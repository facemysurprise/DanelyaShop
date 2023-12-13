import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nd/generated/locale_keys.g.dart';
import 'package:flutter_nd/presentation/blocs/authen_bloc/authen_bloc.dart';
import 'package:flutter_nd/presentation/blocs/authen_bloc/authen_event.dart';
import 'package:flutter_nd/presentation/blocs/authen_bloc/authen_state.dart';
import 'package:flutter_nd/presentation/pages/color.dart';
import 'package:flutter_nd/presentation/pages/lang.dart';
import 'package:flutter_nd/presentation/pages/navigation.dart';
import 'registration_page.dart';

class LoginPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Login.tr(), style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: ColorColors.color12,
        elevation: 0,
        actions: [
            Language(),
          ],
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Bttom()));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30),
                  _buildTextField(_emailController, LocaleKeys.Email.tr(), Icons.email),
                  SizedBox(height: 15),
                  _buildTextField(_passwordController, LocaleKeys.Password.tr(), Icons.lock, isPassword: true),
                  SizedBox(height: 20),
                  _buildButton(context, LocaleKeys.Signin.tr(), ColorColors.primaryColor, () {
                    BlocProvider.of<AuthBloc>(context).add(
                      SignInRequested(_emailController.text, _passwordController.text),
                    );
                  }),
                  SizedBox(height: 10),
                  _buildButton(context, LocaleKeys.Signup.tr(), ColorColors.secondaryColor, () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegistrationPage()));
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isPassword = false}) {
    return TextField(
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
    );
  }

  Widget _buildButton(BuildContext context, String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      ),
    );
  }
}
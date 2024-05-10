import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:tugas_api_prak/screens/login.dart';


class Registration_Page extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<Registration_Page> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pswdController = TextEditingController(); // Menggunakan _pswdController
  TextEditingController _dmyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrasi'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _pswdController, // Menggunakan _pswdController
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: _dmyController,
              decoration: InputDecoration(labelText: 'Tanggal Lahir'),
              readOnly: true,
              onTap: () => _selectDate(context),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: Text('Daftar'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login_Page()),
                );
              },
              child: Text('Sudah punya akun? Login di sini'),
            ),
          ],
        ),
      ),
    );
  }

  void _register() {
    String email = _emailController.text;
    String password = _pswdController.text; // Menggunakan pswd
    String dmy = _dmyController.text;

    if (email.isNotEmpty && password.isNotEmpty && dmy.isNotEmpty) {
      if (_verifyEmailAddress(email)) {
        _saveData(email, password, dmy);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registrasi berhasil!'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Format email tidak valid.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Harap isi semua kolom.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  bool _verifyEmailAddress(String email) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp emailRegex = RegExp(emailPattern);
    return emailRegex.hasMatch(email) && email.contains('@');
  }

  Future<void> _saveData(String email, String password, String dmy) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password); // Menggunakan pswd
    await prefs.setString('dmy', dmy);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        String formattedDate = DateFormat('MMMM d, yyyy').format(picked);
        _dmyController.text = formattedDate;
      });
    }
  }
}

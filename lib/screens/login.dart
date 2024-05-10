import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_api_prak/screens/homepage.dart';
import 'package:tugas_api_prak/screens/registrasi.dart';

class Login_Page extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Login_Page> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pswdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkStatusLogin();
  }

  Future<void> _checkStatusLogin() async {
    SharedPreferences prf = await SharedPreferences.getInstance();
    bool isLoggedIn = prf.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }

  Future<Map<String, String>> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';
    String password = prefs.getString('password') ?? '';
    return {'email': email, 'password': password};
  }

  Future<void> _saveLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _pswdController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Masuk'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Registration_Page()),
                );
              },
              child: Text('Belum punya akun? Daftar di sini'),
            ),
          ],
        ),
      ),
    );
  }

  void _login() async {
    String email = _emailController.text;
    String pswd = _pswdController.text;

    if (email.isNotEmpty && pswd.isNotEmpty) {
      // Lakukan pengecekan login di sini
      // Misalnya, Anda bisa membandingkan dengan informasi yang disimpan di SharedPreferences
      Map<String, String> userData = await _getUserData();
      String savedEmail = userData['email'] ?? '';
      String savedPassword = userData['password'] ?? '';

      if (email == savedEmail && pswd == savedPassword) {
        // Jika login berhasil, simpan status login dan arahkan ke halaman beranda
        await _saveLoginStatus(true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // Jika login gagal, tampilkan pesan kesalahan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Email atau kata sandi salah.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      // Jika email atau kata sandi kosong, tampilkan pesan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Harap isi semua kolom.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}

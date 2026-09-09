
import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  String? _errorMessage;

  static const Color mclarenOrange = Color(0xFFFF8000);

  static const String _validUsername = 'admin';
  static const String _validPassword = 'admin81';

  void _login() {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text.trim();
      final password = _passwordController.text.trim();

      if (username == _validUsername && password == _validPassword) {
        setState(() => _errorMessage = null);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(username: username),
          ),
        );
      } else {
        setState(() {
          _errorMessage = 'Username atau password salah!';
        });
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //login

            Container(
              width: double.infinity,
              height: 230,
              color: mclarenOrange,
              alignment: Alignment.center,
              child: const Text(
                'LOGIN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),

           //form login

            Padding(
              padding: const EdgeInsets.fromLTRB(30, 55, 30, 30),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Username',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF202833),
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        hintText: 'Masukkan username',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: const BorderSide(
                            color: mclarenOrange,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: const BorderSide(
                            color: mclarenOrange,
                            width: 2.5,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 15,
                        ),
                      ),
                      validator: (value) =>
                          (value == null || value.isEmpty)
                              ? 'Username tidak boleh kosong'
                              : null,
                    ),

                    const SizedBox(height: 30),

                    // PASSWORD
                    const Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF202833),
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'Masukkan password',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: const BorderSide(
                            color: mclarenOrange,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: const BorderSide(
                            color: mclarenOrange,
                            width: 2.5,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 15,
                        ),
                      ),
                      validator: (value) =>
                          (value == null || value.isEmpty)
                              ? 'Password tidak boleh kosong'
                              : null,
                    ),

                    // PESAN ERROR
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                    ],

                    const SizedBox(height: 30),

                   //button login
                   
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ButtonStyle(
                          elevation: WidgetStateProperty.all(0),

                          padding: WidgetStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 14),
                          ),

                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                              side: const BorderSide(
                                color: mclarenOrange,
                                width: 2,
                              ),
                            ),
                          ),

                          backgroundColor:
                              WidgetStateProperty.resolveWith<Color>(
                            (states) {
                              if (states.contains(WidgetState.pressed)) {
                                return mclarenOrange;
                              }

                              return Colors.white;
                            },
                          ),

                          // Efek saat tombol ditekan
                          overlayColor: WidgetStateProperty.all(
                            mclarenOrange.withOpacity(0.15),
                          ),
                        ),

                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
                            color: mclarenOrange,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
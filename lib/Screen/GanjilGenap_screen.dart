import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GanjilGenapScreen(),
    );
  }
}

class GanjilGenapScreen extends StatefulWidget {
  const GanjilGenapScreen({super.key});

  @override
  State<GanjilGenapScreen> createState() => _GanjilGenapScreenState();
}

class _GanjilGenapScreenState extends State<GanjilGenapScreen> {
  static const Color mclarenOrange = Color(0xFFFF8000);
  
  final TextEditingController _angkaController = TextEditingController();
  
  String _hasilTeks = 'Hasil';

  // =========================
  // LOGIKA PENGECEKAN
  // =========================
  void _cekGanjilGenap() {

    String input = _angkaController.text.replaceAll(',', '').trim();

    setState(() {
      if (input.isEmpty) {
        _hasilTeks = "Masukkan angka!";
        return; 
      }

      BigInt? angkaBulat = BigInt.tryParse(input);

      if (angkaBulat != null) {
        if (angkaBulat.isEven) {
          _hasilTeks = "Genap";
        } else {
          _hasilTeks = "Ganjil";
        }
      } else {
        _hasilTeks = "Input tidak valid!";
      }
    });
  }

  @override
  void dispose() {
    _angkaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // =========================
      // APP BAR
      // =========================
      appBar: AppBar(
        backgroundColor: mclarenOrange,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Bilangan Ganjil / Genap',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // =========================
      // BODY
      // =========================
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 400,
            ),
            child: Column(
              children: [

                // =========================
                // KOTAK MASUKAN ANGKA
                // =========================
                TextField(
                  controller: _angkaController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  
                  // Pasang formatter ribuan otomatis di sini
                  inputFormatters: [
                    RibuanFormatter(),
                  ],

                  decoration: InputDecoration(
                    hintText: 'Masukkan angka',
                    prefixIcon: const Icon(
                      Icons.numbers,
                      color: mclarenOrange,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: mclarenOrange,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: mclarenOrange,
                        width: 2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // =========================
                // TOMBOL CEK
                // =========================
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _cekGanjilGenap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mclarenOrange,
                      foregroundColor: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Cek Bilangan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // =========================
                // HASIL
                // =========================
                Container(
                  width: double.infinity,
                  height: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3E6),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: mclarenOrange,
                      width: 2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _hasilTeks,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: mclarenOrange,
                      fontSize: 24, 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =========================
// CUSTOM FORMATTER RIBUAN
// =========================
class RibuanFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final textHanyaAngka = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    String teksBaru = '';
    for (int i = 0; i < textHanyaAngka.length; i++) {
      if (i != 0 && (textHanyaAngka.length - i) % 3 == 0) {
        teksBaru += ',';
      }
      teksBaru += textHanyaAngka[i];
    }

    return TextEditingValue(
      text: teksBaru,
      selection: TextSelection.collapsed(offset: teksBaru.length),
    );
  }
}
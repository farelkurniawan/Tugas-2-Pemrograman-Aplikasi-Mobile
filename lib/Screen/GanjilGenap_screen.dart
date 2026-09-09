import 'package:flutter/material.dart';

class GanjilGenapScreen extends StatelessWidget {
  const GanjilGenapScreen({super.key});

  static const Color mclarenOrange = Color(0xFFFF8000);

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
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,

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
                    onPressed: () {},

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

                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3E6),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: mclarenOrange,
                      width: 2,
                    ),
                  ),

                  alignment: Alignment.center,

                  child: const Text(
                    'Hasil',
                    style: TextStyle(
                      color: mclarenOrange,
                      fontSize: 28,
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
import 'package:flutter/material.dart';

class OperasiAritmatikaScreen extends StatelessWidget {
  const OperasiAritmatikaScreen({super.key});

  static const Color mclarenOrange = Color(0xFFFF8000);

  // Widget tombol operasi
  Widget tombolOperasi(String simbol, String nama) {
    return Expanded(
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: mclarenOrange,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              simbol,
              style: const TextStyle(
                color: mclarenOrange,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              nama,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
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
          'Operasi Aritmatika',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // =========================
      // BODY
      // =========================

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 400,
              ),

              child: Column(
                children: [

                  // =========================
                  // INPUT ANGKA
                  // =========================

                  Row(
                    children: [

                      Expanded(
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Angka 1',

                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: mclarenOrange,
                                width: 2,
                              ),
                            ),

                            enabledBorder:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: mclarenOrange,
                                width: 2,
                              ),
                            ),

                            focusedBorder:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: mclarenOrange,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 15),

                      Expanded(
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Angka 2',

                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: mclarenOrange,
                                width: 2,
                              ),
                            ),

                            enabledBorder:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: mclarenOrange,
                                width: 2,
                              ),
                            ),

                            focusedBorder:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: mclarenOrange,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // =========================
                  // OPERASI + DAN -
                  // =========================

                  Row(
                    children: [
                      tombolOperasi('+', 'Tambah'),

                      const SizedBox(width: 15),

                      tombolOperasi('-', 'Kurang'),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // =========================
                  // OPERASI × DAN ÷
                  // =========================

                  Row(
                    children: [
                      tombolOperasi('×', 'Kali'),

                      const SizedBox(width: 15),

                      tombolOperasi('÷', 'Bagi'),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // =========================
                  // HASIL
                  // =========================

                  Container(
                    width: double.infinity,
                    height: 100,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: mclarenOrange,
                        width: 2,
                      ),
                      borderRadius:
                          BorderRadius.circular(8),
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
      ),
    );
  }
}
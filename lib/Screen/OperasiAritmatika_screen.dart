import 'package:flutter/material.dart';

class OperasiAritmatikaScreen extends StatefulWidget {
  const OperasiAritmatikaScreen({super.key});

  @override
  State<OperasiAritmatikaScreen> createState() =>
      _OperasiAritmatikaScreenState();
}

class _OperasiAritmatikaScreenState
    extends State<OperasiAritmatikaScreen> {
  static const Color mclarenOrange = Color(0xFFFF8000);

  final TextEditingController pengendaliAngka1 =
      TextEditingController();

  final TextEditingController pengendaliAngka2 =
      TextEditingController();

  String hasil = '';
  String pesanKesalahan = '';

  void hitung(String operasi) {
    setState(() {
      hasil = '';
      pesanKesalahan = '';
    });

    String teksAngka1 =
        pengendaliAngka1.text.trim().replaceAll(',', '.');

    String teksAngka2 =
        pengendaliAngka2.text.trim().replaceAll(',', '.');

    // Validasi input kosong
    if (teksAngka1.isEmpty || teksAngka2.isEmpty) {
      setState(() {
        pesanKesalahan = 'Kedua angka harus diisi.';
      });
      return;
    }

    // Validasi format angka
    final RegExp formatAngkaValid =
        RegExp(r'^-?\d+([.]\d+)?$');

    if (!formatAngkaValid.hasMatch(teksAngka1) ||
        !formatAngkaValid.hasMatch(teksAngka2)) {
      setState(() {
        pesanKesalahan = 'Input harus berupa angka yang valid.';
      });
      return;
    }

    num angka1;
    num angka2;

    try {
      angka1 = ubahKeAngka(teksAngka1);
      angka2 = ubahKeAngka(teksAngka2);
    } catch (e) {
      setState(() {
        pesanKesalahan = 'Format angka tidak valid.';
      });
      return;
    }

    num hasilPerhitungan;

    switch (operasi) {
      case '+':
        hasilPerhitungan = angka1 + angka2;
        break;

      case '−':
        hasilPerhitungan = angka1 - angka2;
        break;

      case '×':
        hasilPerhitungan = angka1 * angka2;
        break;

      case '÷':
        if (angka2 == 0) {
          setState(() {
            pesanKesalahan = 'Tidak dapat membagi dengan nol.';
          });
          return;
        }

        hasilPerhitungan = angka1 / angka2;
        break;

      default:
        setState(() {
          pesanKesalahan = 'Operasi tidak valid.';
        });
        return;
    }

    setState(() {
      hasil = formatHasil(hasilPerhitungan);
    });
  }

  num ubahKeAngka(String teks) {
    if (teks.contains('.')) {
      return double.parse(teks);
    }

    return int.parse(teks);
  }

  String formatHasil(num nilai) {
    if (nilai is int) {
      return formatRibuan(nilai.toString());
    }

    double nilaiDesimal = nilai.toDouble();

    if (nilaiDesimal == nilaiDesimal.truncateToDouble()) {
      return formatRibuan(
        nilaiDesimal.toInt().toString(),
      );
    }

    String teks = nilaiDesimal.toStringAsFixed(10);

    teks = teks.replaceFirst(RegExp(r'0+$'), '');
    teks = teks.replaceFirst(RegExp(r'[.]$'), '');

    if (teks.contains('.')) {
      List<String> bagian = teks.split('.');

      return '${formatRibuan(bagian[0])},${bagian[1]}';
    }

    return formatRibuan(teks);
  }

  String formatRibuan(String teks) {
    bool negatif = teks.startsWith('-');

    if (negatif) {
      teks = teks.substring(1);
    }

    String hasilFormat = '';

    for (int i = 0; i < teks.length; i++) {
      if (i > 0 && (teks.length - i) % 3 == 0) {
        hasilFormat += '.';
      }

      hasilFormat += teks[i];
    }

    if (negatif) {
      hasilFormat = '-$hasilFormat';
    }

    return hasilFormat;
  }

  Widget tombolOperasi(String simbol, String nama) {
    return Expanded(
      child: SizedBox(
        height: 70,
        child: OutlinedButton(
          onPressed: () => hitung(simbol),
          style: OutlinedButton.styleFrom(
            foregroundColor: mclarenOrange,
            side: const BorderSide(
              color: mclarenOrange,
              width: 2,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                simbol,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                nama,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    pengendaliAngka1.dispose();
    pengendaliAngka2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

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
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: pengendaliAngka1,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                            signed: true,
                          ),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Angka 1',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: mclarenOrange,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(12),
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
                          controller: pengendaliAngka2,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                            signed: true,
                          ),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Angka 2',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: mclarenOrange,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(12),
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

                  Row(
                    children: [
                      tombolOperasi('+', 'Tambah'),
                      const SizedBox(width: 15),
                      tombolOperasi('−', 'Kurang'),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      tombolOperasi('×', 'Kali'),
                      const SizedBox(width: 15),
                      tombolOperasi('÷', 'Bagi'),
                    ],
                  ),

                  const SizedBox(height: 25),

                  if (pesanKesalahan.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(
                        bottom: 15,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.red,
                        ),
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                      child: Text(
                        pesanKesalahan,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  Container(
                    width: double.infinity,
                    height: 100,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius:
                          BorderRadius.circular(15),
                      border: Border.all(
                        color: mclarenOrange,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Hasil',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          hasil.isEmpty ? '-' : hasil,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
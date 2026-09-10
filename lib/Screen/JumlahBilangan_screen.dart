import 'package:flutter/material.dart';

class JumlahBilanganScreen extends StatefulWidget {
  const JumlahBilanganScreen({super.key});

  @override
  State<JumlahBilanganScreen> createState() => _JumlahBilanganScreenState();
}

class _JumlahBilanganScreenState extends State<JumlahBilanganScreen> {
  static const Color mclarenOrange = Color(0xFFFF8000);

  final TextEditingController _inputController = TextEditingController();

  String _hasilTotal = "-";

  void _hitungTotal() {
    String input = _inputController.text;

    if (input.trim().isEmpty) {
      _tampilkanError("Input tidak boleh kosong!");
      return;
    }

    // Samakan semua pemisah yang didukung agar input mudah diproses.
    String normalizedInput = input.replaceAll(RegExp(r'[.,\n]'), ' ');
    List<String> angkaList = normalizedInput.split(RegExp(r'\s+'));

    // BigInt mencegah hasil penjumlahan angka besar kehilangan presisi.
    BigInt total = BigInt.zero;
    List<String> inputInvalid = [];

    for (String item in angkaList) {
      if (item.trim().isEmpty) continue;

      try {
        BigInt angka = BigInt.parse(item);
        total += angka;
      } catch (e) {
        inputInvalid.add(item);
      }
    }

    if (inputInvalid.isNotEmpty) {
      _tampilkanError("Input tidak valid ditemukan: ${inputInvalid.join(', ')}");
      setState(() {
        _hasilTotal = "Error";
      });
    } else {
      setState(() {
        _hasilTotal = total.toString();
      });
    }
  }

  void _tampilkanError(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mclarenOrange,
        foregroundColor: Colors.white,
        title: const Text(
          'Jumlah Total Angka',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // Memungkinkan konten tetap dapat digulir saat keyboard terbuka.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Jumlah Total Angka',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Masukkan deretan angka untuk dijumlahkan. Pisahkan dengan spasi, koma, atau titik.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 30),
            
            TextField(
              controller: _inputController,
              // Teks diperlukan agar input tidak valid dapat ditampilkan sebagai error.
              keyboardType: TextInputType.text,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Contoh: 1500000, 200000. 100000000000',
                alignLabelWithHint: true,
                labelText: 'Data Angka',
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(bottom: 60),
                  child: Icon(
                    Icons.numbers,
                    color: mclarenOrange,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: mclarenOrange,
                    width: 2,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _hitungTotal,
                style: ElevatedButton.styleFrom(
                  backgroundColor: mclarenOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Hitung Total',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E6),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: mclarenOrange,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      color: mclarenOrange,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _hasilTotal,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
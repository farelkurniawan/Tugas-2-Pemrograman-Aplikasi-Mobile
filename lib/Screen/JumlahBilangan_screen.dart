import 'package:flutter/material.dart';

class JumlahBilanganScreen extends StatefulWidget {
  const JumlahBilanganScreen({super.key});

  @override
  State<JumlahBilanganScreen> createState() => _JumlahBilanganScreenState();
}

class _JumlahBilanganScreenState extends State<JumlahBilanganScreen> {
  static const Color mclarenOrange = Color(0xFFFF8000);
  
  // Controller untuk mengambil data dari TextField
  final TextEditingController _inputController = TextEditingController();
  
  // State untuk menyimpan hasil perhitungan
  String _hasilTotal = "-";

  // Fungsi inti untuk validasi dan kalkulasi
  void _hitungTotal() {
    String input = _inputController.text;
    
    // Pengecekan input kosong
    if (input.trim().isEmpty) {
      _tampilkanError("Input tidak boleh kosong!");
      return;
    }

    // Mengganti semua tanda titik, koma, atau baris baru menjadi spasi
    // Ini menangani *edge case* pemisah karakter yang aneh-aneh
    String normalizedInput = input.replaceAll(RegExp(r'[.,\n]'), ' ');
    
    // Memisahkan string berdasarkan spasi (termasuk spasi yang lebih dari satu)
    List<String> angkaList = normalizedInput.split(RegExp(r'\s+'));
    
    // Menggunakan BigInt untuk menampung angka hingga triliunan dengan aman
    BigInt total = BigInt.zero;
    List<String> inputInvalid = [];

    for (String item in angkaList) {
      if (item.trim().isEmpty) continue; // Skip jika ada string kosong
      
      try {
        // Coba konversi teks ke BigInt
        BigInt angka = BigInt.parse(item);
        total += angka;
      } catch (e) {
        // Jika gagal (berarti ada input huruf/karakter aneh), tangkap errornya
        inputInvalid.add(item);
      }
    }

    // Jika ada satu saja huruf/karakter yang tidak valid
    if (inputInvalid.isNotEmpty) {
      _tampilkanError("Input tidak valid ditemukan: ${inputInvalid.join(', ')}");
      setState(() {
        _hasilTotal = "Error"; // Ubah hasil menjadi error
      });
    } else {
      // Jika semua sukses, update UI
      setState(() {
        _hasilTotal = total.toString();
      });
    }
  }

  // Fungsi penunjang UI untuk menampilkan Pop-up error (SnackBar)
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
    _inputController.dispose(); // Jangan lupa membebaskan memori controller
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
      body: SingleChildScrollView( // Mencegah UI overflow jika keyboard muncul
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
            
            // TextField diubah menjadi 1 area besar (mirip dengan referensi Screenshot)
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.text, // Pakai Text agar user tetap bisa disalahkan kalau ngetik huruf
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
                onPressed: _hitungTotal, // Memanggil fungsi logika
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
                    _hasilTotal, // Variabel State dipanggil di sini
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true, // Memastikan jika angkanya sangat panjang, akan turun ke bawah, tidak terpotong
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
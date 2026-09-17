import 'package:flutter/material.dart';

// Menggunakan StatefulWidget karena antarmuka bersifat dinamis. 
// Hasil perhitungan di layar harus bisa diperbarui (rebuild) setelah tombol ditekan.
class JumlahBilanganScreen extends StatefulWidget {
  const JumlahBilanganScreen({super.key});

  @override
  State<JumlahBilanganScreen> createState() => _JumlahBilanganScreenState();
}

class _JumlahBilanganScreenState extends State<JumlahBilanganScreen> {
  static const Color mclarenOrange = Color(0xFFFF8000);

  // Controller berfungsi sebagai jembatan untuk menarik teks yang diketik user dari TextField.
  final TextEditingController _inputController = TextEditingController();

  // Menyimpan state hasil perhitungan awal sebelum ada aksi.
  String _hasilTotal = "-";

  void _hitungTotal() {
    String input = _inputController.text;

    // Proteksi 1: Hentikan fungsi jika user hanya menekan tombol pada kotak kosong/berisi spasi.
    if (input.trim().isEmpty) {
      _tampilkanError("Input tidak boleh kosong!");
      return;
    }

    // Proteksi 2 & Logika Inti: Pencocokan Pola (Pattern Matching).
    // RegExp \d+ memindai seluruh teks dan HANYA mengekstrak deretan angka yang bergandengan.
    // Karakter huruf, spasi, dan tanda baca otomatis diabaikan tanpa memicu error/crash.
    Iterable<RegExpMatch> matches = RegExp(r'\d+').allMatches(input);
    
    // Proteksi 3: Menggunakan BigInt (bukan int) agar sistem kebal terhadap integer overflow 
    // jika user menginputkan angka berskala miliaran atau triliunan.
    BigInt total = BigInt.zero;
    
    for (final match in matches) {
      // Mengubah string hasil temuan Regex menjadi nilai matematis lalu diakumulasikan.
      total += BigInt.parse(match.group(0)!); 
    }

    // Proteksi 4: Handle kasus di mana user memasukkan teks panjang tapi murni tanpa angka.
    if (matches.isEmpty) {
      _tampilkanError("Tidak ada angka yang ditemukan dalam teks tersebut.");
      setState(() {
        _hasilTotal = "0";
      });
      return;
    }

    // Memicu proses render ulang (rebuild) pada UI untuk menampilkan hasil akhir perhitungan.
    setState(() {
      _hasilTotal = total.toString();
    });
  }

  // Fungsi modular untuk menampilkan alert error (SnackBar) agar kode utama tetap bersih.
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
    // Wajib: Menghancurkan controller saat berpindah/menutup layar untuk mencegah memory leak.
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
          'Ekstraksi Total Angka',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // SingleChildScrollView mencegah "UI Overflow" (garis kuning-hitam) 
      // saat keyboard virtual HP muncul dan mendesak layar ke atas.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hitung Angka dari Teks',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Paste teks, artikel, atau berita di bawah ini. Sistem otomatis mendeteksi dan menjumlahkan semua angka di dalamnya.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 30),
            
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.multiline,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: 'Contoh: Gempa terjadi pada tahun 2026 dengan kekuatan 5 skala richter...',
                alignLabelWithHint: true,
                labelText: 'Paste Teks di Sini',
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(bottom: 100),
                  child: Icon(
                    Icons.document_scanner,
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
                  'Ekstraksi & Hitung Total',
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
                    'Total Angka',
                    style: TextStyle(
                      color: mclarenOrange,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _hasilTotal,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    // Memastikan teks angka raksasa akan turun ke baris baru, bukan terpotong.
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
import 'package:flutter/material.dart';

import 'Login_screen.dart';
import 'GanjilGenap_screen.dart';
import 'JumlahBilangan_screen.dart';
import 'OperasiAritmatika_screen.dart';

class HomeScreen extends StatelessWidget {
  final String username;

  const HomeScreen({
    super.key,
    required this.username,
  });

  static const Color mclarenOrange = Color(0xFFFF8000);
  static const Color darkText = Color(0xFF202124);
  static const Color lightBackground = Color(0xFFF7F7F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,

      // =========================
      // APP BAR
      // =========================
      appBar: AppBar(
        backgroundColor: mclarenOrange,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'MENU UTAMA',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout_rounded),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),

      // =========================
      // BODY
      // =========================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // =========================
            // WELCOME CARD
            // =========================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [

                  // Icon
                  Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      color: mclarenOrange,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),

                  const SizedBox(width: 18),

                  // Text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Selamat datang 👋',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          username,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: darkText,
                          ),
                        ),

                        const SizedBox(height: 4),

                        const Text(
                          'Siap menggunakan McCalculator hari ini?',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // =========================
            // DATA KELOMPOK
            // =========================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'ANGGOTA KELOMPOK',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: darkText,
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: mclarenOrange.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Mobile SI-C',
                    style: TextStyle(
                      color: mclarenOrange,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _memberItem(
                    '01',
                    'Muhammad Alfarel Yudan Kurniawan',
                    '124240163',
                  ),

                  const Divider(height: 22),

                  _memberItem(
                    '02',
                    'Azizah Mualifah',
                    '124240165',
                  ),

                  const Divider(height: 22),

                  _memberItem(
                    '03',
                    'Agnaita Naswa Fadilla',
                    '124240166',
                  ),

                  const Divider(height: 22),

                  _memberItem(
                    '04',
                    'Naila Faiza Ramadani',
                    '124240177',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // =========================
            // MENU
            // =========================
            const Text(
              'PILIH PROGRAM',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: darkText,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Pilih program yang ingin digunakan',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 18),

            // =========================
            // MENU 1
            // =========================
            _menuCard(
              context: context,
              number: '01',
              icon: Icons.calculate_rounded,
              title: 'Operasi Aritmatika',
              description:
                  'Penjumlahan, pengurangan, perkalian, dan pembagian',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const OperasiAritmatikaScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 14),

            // =========================
            // MENU 2
            // =========================
            _menuCard(
              context: context,
              number: '02',
              icon: Icons.numbers_rounded,
              title: 'Bilangan Ganjil / Genap',
              description:
                  'Menentukan bilangan ganjil atau genap',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const GanjilGenapScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 14),

            // =========================
            // MENU 3
            // =========================
            _menuCard(
              context: context,
              number: '03',
              icon: Icons.functions_rounded,
              title: 'Jumlah Total Angka',
              description:
                  'Menghitung jumlah total dari beberapa angka',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const JumlahBilanganScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 25),

            // =========================
            // FOOTER
            // =========================
            Center(
              child: Text(
                'Pemrograman Aplikasi Mobile',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                ),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // MEMBER ITEM
  // =========================================================
  Widget _memberItem(
    String number,
    String name,
    String nim,
  ) {
    return Row(
      children: [

        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: mclarenOrange.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: mclarenOrange,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: darkText,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                nim,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // =========================================================
  // MENU CARD
  // =========================================================
  Widget _menuCard({
    required BuildContext context,
    required String number,
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [

              // ICON
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: mclarenOrange,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 28,
                ),
              ),

              const SizedBox(width: 16),

              // TEXT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [
                        Text(
                          number,
                          style: const TextStyle(
                            color: mclarenOrange,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(width: 8),

                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: darkText,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              // ARROW
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: mclarenOrange.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: mclarenOrange,
                  size: 19,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
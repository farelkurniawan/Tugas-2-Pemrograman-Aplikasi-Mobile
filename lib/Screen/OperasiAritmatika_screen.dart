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

  // HITUNG

  void hitung(String operasi) {
    setState(() {
      hasil = '';
      pesanKesalahan = '';
    });

    String teksAngka1 =
        pengendaliAngka1.text.trim().replaceAll(',', '.');

    String teksAngka2 =
        pengendaliAngka2.text.trim().replaceAll(',', '.');

  
    // VALIDASI INPUT KOSONG

    if (teksAngka1.isEmpty || teksAngka2.isEmpty) {
      setState(() {
        pesanKesalahan = 'Kedua angka harus diisi.';
      });
      return;
    }

    // VALIDASI FORMAT ANGKA
  
    final RegExp formatAngkaValid =
        RegExp(r'^-?\d+([.]\d+)?$');

    if (!formatAngkaValid.hasMatch(teksAngka1) ||
        !formatAngkaValid.hasMatch(teksAngka2)) {
      setState(() {
        pesanKesalahan =
            'Input harus berupa angka yang valid.';
      });
      return;
    }

    try {
      String hasilPerhitungan;

      if (!teksAngka1.contains('.') &&
          !teksAngka2.contains('.')) {
        BigInt angka1 = BigInt.parse(teksAngka1);
        BigInt angka2 = BigInt.parse(teksAngka2);

        switch (operasi) {
          case '+':
            hasilPerhitungan =
                formatRibuan(
              (angka1 + angka2).toString(),
            );
            break;

          case '−':
            hasilPerhitungan =
                formatRibuan(
              (angka1 - angka2).toString(),
            );
            break;

          case '×':
            hasilPerhitungan =
                formatRibuan(
              (angka1 * angka2).toString(),
            );
            break;

          case '÷':
            if (angka2 == BigInt.zero) {
              setState(() {
                pesanKesalahan =
                    'Tidak dapat membagi dengan nol.';
              });
              return;
            }

            hasilPerhitungan =
                hitungBagiBigInt(
              angka1,
              angka2,
            );
            break;

          default:
            setState(() {
              pesanKesalahan =
                  'Operasi tidak valid.';
            });
            return;
        }
      }

      // KALAU ADA ANGKA DESIMAL
      
      else {
        hasilPerhitungan = hitungDesimal(
          teksAngka1,
          teksAngka2,
          operasi,
        );
      }

      setState(() {
        hasil = hasilPerhitungan;
      });
    } catch (e) {
      setState(() {
        pesanKesalahan =
            'Format angka tidak valid.';
      });
    }
  }

  // PERHITUNGAN DESIMAL
  String hitungDesimal(
    String teksAngka1,
    String teksAngka2,
    String operasi,
  ) {
    List<String> bagian1 =
        teksAngka1.split('.');

    List<String> bagian2 =
        teksAngka2.split('.');

    String angkaBulat1 =
        bagian1[0];

    String angkaBulat2 =
        bagian2[0];

    String desimal1 =
        bagian1.length > 1
            ? bagian1[1]
            : '';

    String desimal2 =
        bagian2.length > 1
            ? bagian2[1]
            : '';

    int skala1 =
        desimal1.length;

    int skala2 =
        desimal2.length;

    String nilai1 =
        angkaBulat1 + desimal1;

    String nilai2 =
        angkaBulat2 + desimal2;

    BigInt angka1 =
        BigInt.parse(nilai1);

    BigInt angka2 =
        BigInt.parse(nilai2);

    switch (operasi) {
      case '+':
        return hitungTambahDesimal(
          angka1,
          skala1,
          angka2,
          skala2,
        );

      case '−':
        return hitungKurangDesimal(
          angka1,
          skala1,
          angka2,
          skala2,
        );

      case '×':
        BigInt hasilKali =
            angka1 * angka2;

        int skalaHasil =
            skala1 + skala2;

        return formatBigIntDesimal(
          hasilKali,
          skalaHasil,
        );

      case '÷':
        double nilaiDouble1 =
            double.parse(teksAngka1);

        double nilaiDouble2 =
            double.parse(teksAngka2);

        if (nilaiDouble2 == 0) {
          setState(() {
            pesanKesalahan =
                'Tidak dapat membagi dengan nol.';
          });

          return '';
        }

        return formatDesimal(
          nilaiDouble1 / nilaiDouble2,
        );

      default:
        return 'Operasi tidak valid.';
    }
  }

  // TAMBAH DESIMAL DENGAN BIGINT

  String hitungTambahDesimal(
    BigInt angka1,
    int skala1,
    BigInt angka2,
    int skala2,
  ) {
    int skala = skala1;

    BigInt nilai1 = angka1;
    BigInt nilai2 = angka2;

    if (skala1 < skala2) {
      int selisih =
          skala2 - skala1;

      nilai1 *=
          BigInt.from(10).pow(selisih);

      skala = skala2;
    } else if (skala2 < skala1) {
      int selisih =
          skala1 - skala2;

      nilai2 *=
          BigInt.from(10).pow(selisih);

      skala = skala1;
    }

    BigInt hasil =
        nilai1 + nilai2;

    return formatBigIntDesimal(
      hasil,
      skala,
    );
  }

  // KURANG DESIMAL DENGAN BIGINT
  String hitungKurangDesimal(
    BigInt angka1,
    int skala1,
    BigInt angka2,
    int skala2,
  ) {
    int skala = skala1;

    BigInt nilai1 = angka1;
    BigInt nilai2 = angka2;

    if (skala1 < skala2) {
      int selisih =
          skala2 - skala1;

      nilai1 *=
          BigInt.from(10).pow(selisih);

      skala = skala2;
    } else if (skala2 < skala1) {
      int selisih =
          skala1 - skala2;

      nilai2 *=
          BigInt.from(10).pow(selisih);

      skala = skala1;
    }

    BigInt hasil =
        nilai1 - nilai2;

    return formatBigIntDesimal(
      hasil,
      skala,
    );
  }

  // FORMAT BIGINT DESIMAL
  String formatBigIntDesimal(
    BigInt nilai,
    int skala,
  ) {
    if (skala == 0) {
      return formatRibuan(
        nilai.toString(),
      );
    }

    bool negatif =
        nilai.isNegative;

    if (negatif) {
      nilai = nilai.abs();
    }

    String teks =
        nilai.toString();

    while (teks.length <= skala) {
      teks = '0$teks';
    }

    int posisiKoma =
        teks.length - skala;

    String bagianBulat =
        teks.substring(
      0,
      posisiKoma,
    );

    String bagianDesimal =
        teks.substring(
      posisiKoma,
    );

    bagianDesimal =
        bagianDesimal.replaceFirst(
      RegExp(r'0+$'),
      '',
    );

    if (bagianDesimal.isEmpty) {
      String hasilBulat =
          formatRibuan(
        bagianBulat,
      );

      if (negatif &&
          hasilBulat != '0') {
        return '-$hasilBulat';
      }

      return hasilBulat;
    }

    String hasil =
        '${formatRibuan(bagianBulat)},$bagianDesimal';

    if (negatif) {
      hasil = '-$hasil';
    }

    return hasil;
  }

  // PEMBAGIAN BIGINT
  String hitungBagiBigInt(
    BigInt angka1,
    BigInt angka2,
  ) {
    BigInt hasilBagi =
        angka1 ~/ angka2;

    BigInt sisa =
        angka1 % angka2;

    String hasilUtama =
        formatRibuan(
      hasilBagi.toString(),
    );

    if (sisa == BigInt.zero) {
      return hasilUtama;
    }

    bool negatif =
        angka1.isNegative !=
            angka2.isNegative;

    BigInt sisaPositif =
        sisa.abs();

    BigInt pembagiPositif =
        angka2.abs();

    String desimal = '';

    for (int i = 0; i < 10; i++) {
      sisaPositif *=
          BigInt.from(10);

      BigInt angkaDesimal =
          sisaPositif ~/
              pembagiPositif;

      desimal +=
          angkaDesimal.toString();

      sisaPositif =
          sisaPositif %
              pembagiPositif;

      if (sisaPositif ==
          BigInt.zero) {
        break;
      }
    }

    desimal =
        desimal.replaceFirst(
      RegExp(r'0+$'),
      '',
    );

    if (desimal.isEmpty) {
      return hasilUtama;
    }

    if (negatif) {
      hasilUtama =
          '-$hasilUtama';
    }

    return '$hasilUtama,$desimal';
  }


  // FORMAT DESIMAL
  String formatDesimal(
    double nilai,
  ) {
    if (nilai.isNaN ||
        nilai.isInfinite) {
      return 'Hasil tidak valid';
    }

    if (nilai ==
        nilai.truncateToDouble()) {
      return formatRibuan(
        nilai.toInt().toString(),
      );
    }

    String teks =
        nilai.toStringAsFixed(10);

    teks =
        teks.replaceFirst(
      RegExp(r'0+$'),
      '',
    );

    teks =
        teks.replaceFirst(
      RegExp(r'[.]$'),
      '',
    );

    List<String> bagian =
        teks.split('.');

    return '${formatRibuan(bagian[0])},${bagian[1]}';
  }
  // FORMAT RIBUAN
  String formatRibuan(
    String teks,
  ) {
    bool negatif =
        teks.startsWith('-');

    if (negatif) {
      teks =
          teks.substring(1);
    }

    String hasilFormat = '';

    for (int i = 0;
        i < teks.length;
        i++) {
      if (i > 0 &&
          (teks.length - i) % 3 == 0) {
        hasilFormat += '.';
      }

      hasilFormat +=
          teks[i];
    }

    if (negatif) {
      hasilFormat =
          '-$hasilFormat';
    }

    return hasilFormat;
  }
  // TOMBOL OPERASI
  Widget tombolOperasi(
    String simbol,
    String nama,
  ) {
    return Expanded(
      child: SizedBox(
        height: 70,
        child: OutlinedButton(
          onPressed: () =>
              hitung(simbol),
          style:
              OutlinedButton.styleFrom(
            foregroundColor:
                mclarenOrange,
            side:
                const BorderSide(
              color:
                  mclarenOrange,
              width: 2,
            ),
            shape:
                RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(
                15,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              Text(
                simbol,
                style:
                    const TextStyle(
                  fontSize: 26,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              Text(
                nama,
                style:
                    const TextStyle(
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
  // UI
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          Colors.white,

      appBar: AppBar(
        backgroundColor:
            mclarenOrange,
        foregroundColor:
            Colors.white,
        elevation: 0,
        title: const Text(
          'Operasi Aritmatika',
          style: TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.all(20),

            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(
                maxWidth: 400,
              ),

              child: Column(
                children: [

                  // INPUT ANGKA
                  

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller:
                              pengendaliAngka1,

                          keyboardType:
                              const TextInputType
                                  .numberWithOptions(
                            decimal: true,
                            signed: true,
                          ),

                          textAlign:
                              TextAlign.center,

                          decoration:
                              InputDecoration(
                            hintText:
                                'Angka 1',

                            border:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                12,
                              ),
                            ),

                            enabledBorder:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                12,
                              ),

                              borderSide:
                                  const BorderSide(
                                color:
                                    mclarenOrange,
                              ),
                            ),

                            focusedBorder:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                12,
                              ),

                              borderSide:
                                  const BorderSide(
                                color:
                                    mclarenOrange,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 15,
                      ),

                      Expanded(
                        child: TextField(
                          controller:
                              pengendaliAngka2,

                          keyboardType:
                              const TextInputType
                                  .numberWithOptions(
                            decimal: true,
                            signed: true,
                          ),

                          textAlign:
                              TextAlign.center,

                          decoration:
                              InputDecoration(
                            hintText:
                                'Angka 2',

                            border:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                12,
                              ),
                            ),

                            enabledBorder:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                12,
                              ),

                              borderSide:
                                  const BorderSide(
                                color:
                                    mclarenOrange,
                              ),
                            ),

                            focusedBorder:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                12,
                              ),

                              borderSide:
                                  const BorderSide(
                                color:
                                    mclarenOrange,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  
                  // TOMBOL TAMBAH DAN KURANG
                  

                  Row(
                    children: [
                      tombolOperasi(
                        '+',
                        'Tambah',
                      ),

                      const SizedBox(
                        width: 15,
                      ),

                      tombolOperasi(
                        '−',
                        'Kurang',
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  
                  // TOMBOL KALI DAN BAGI
                  

                  Row(
                    children: [
                      tombolOperasi(
                        '×',
                        'Kali',
                      ),

                      const SizedBox(
                        width: 15,
                      ),

                      tombolOperasi(
                        '÷',
                        'Bagi',
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  
                  // PESAN ERROR
                  
                  if (pesanKesalahan.isNotEmpty)
                    Container(
                      width:
                          double.infinity,

                      padding:
                          const EdgeInsets.all(
                        12,
                      ),

                      margin:
                          const EdgeInsets.only(
                        bottom: 15,
                      ),

                      decoration:
                          BoxDecoration(
                        border:
                            Border.all(
                          color:
                              Colors.red,
                        ),

                        borderRadius:
                            BorderRadius.circular(
                          12,
                        ),
                      ),

                      child: Text(
                        pesanKesalahan,

                        textAlign:
                            TextAlign.center,

                        style:
                            const TextStyle(
                          color:
                              Colors.red,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),

                  
                  // HASIL
                  

                  Container(
                    width:
                        double.infinity,

                    constraints:
                        const BoxConstraints(
                      minHeight: 100,
                    ),

                    padding:
                        const EdgeInsets.all(
                      15,
                    ),

                    decoration:
                        BoxDecoration(
                      color:
                          Colors.grey.shade100,

                      borderRadius:
                          BorderRadius.circular(
                        15,
                      ),

                      border:
                          Border.all(
                        color:
                            mclarenOrange,
                        width: 2,
                      ),
                    ),

                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center,

                      children: [
                        const Text(
                          'Hasil',

                          style:
                              TextStyle(
                            fontSize: 16,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        Text(
                          hasil.isEmpty
                              ? '-'
                              : hasil,

                          textAlign:
                              TextAlign.center,

                          

                          softWrap: true,

                          style:
                              const TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight.bold,
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
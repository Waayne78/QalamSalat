import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/app_theme.dart';
import 'audio_player_popup.dart';

class QuranView extends StatefulWidget {
  const QuranView({Key? key}) : super(key: key);

  @override
  State<QuranView> createState() => _QuranViewState();
}

class _QuranViewState extends State<QuranView> {
  void openAudioPlayerDialog(String surahName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AudioPlayerPage(
          surahName: surahName,
          surahList: [],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightColor,
      appBar: AppBar(
        backgroundColor: AppTheme.lightColor,
        centerTitle: true,
        title: Text(
          'Qalam - Quran',
          style: GoogleFonts.cormorantGaramond(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkColor,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                buildSurahTile(context, "1 - Al Fatiha"),
                buildSurahTile(context, "2 - Al Baqarah"),
                buildSurahTile(context, "3 - Al-'Imran"),
                buildSurahTile(context, "4 - An-Nisa'"),
                buildSurahTile(context, "5 - Al-Ma'idah"),
                buildSurahTile(context, "6 - Al-An'am"),
                buildSurahTile(context, "7 - Al-A'raf"),
                buildSurahTile(context, "8 - Al-Anfal"),
                buildSurahTile(context, "9 - At-Tawbah"),
                buildSurahTile(context, "10 - Yunus"),
                buildSurahTile(context, "11 - Hud"),
                buildSurahTile(context, "12 - Yusuf"),
                buildSurahTile(context, "13 - Ar-Ra'd"),
                buildSurahTile(context, "14 - Ibrahim"),
                buildSurahTile(context, "15 - Al-Hijr"),
                buildSurahTile(context, "16 - An-Nahl"),
                buildSurahTile(context, "17 - Al-Isra"),
                buildSurahTile(context, "18 - Al-Kahf"),
                buildSurahTile(context, "19 - Maryam"),
                buildSurahTile(context, "20 - Ta-Ha"),
                buildSurahTile(context, "21 - Al-Anbiya"),
                buildSurahTile(context, "22 - Al-Hajj"),
                buildSurahTile(context, "23 - Al-Mu'minun"),
                buildSurahTile(context, "24 - An-Nur"),
                buildSurahTile(context, "25 - Al-Furqan"),
                buildSurahTile(context, "26 - Ash-Shu'ara"),
                buildSurahTile(context, "27 - An-Naml"),
                buildSurahTile(context, "28 - Al-Qasas"),
                buildSurahTile(context, "29 - Al-Ankabut"),
                buildSurahTile(context, "30 - Ar-Rum"),
                buildSurahTile(context, "31 - Luqman"),
                buildSurahTile(context, "32 - As-Sajda"),
                buildSurahTile(context, "33 - Al-Ahzab"),
                buildSurahTile(context, "34 - Saba'"),
                buildSurahTile(context, "35 - Fatir"),
                buildSurahTile(context, "36 - Ya-Sin"),
                buildSurahTile(context, "37 - As-Saffat"),
                buildSurahTile(context, "38 - Sad"),
                buildSurahTile(context, "39 - Az-Zumar"),
                buildSurahTile(context, "40 - Ghafir"),
                buildSurahTile(context, "41 - Fussilat"),
                buildSurahTile(context, "42 - Ash-Shura"),
                buildSurahTile(context, "43 - Az-Zukhruf"),
                buildSurahTile(context, "44 - Ad-Dukhan"),
                buildSurahTile(context, "45 - Al-Jathiya"),
                buildSurahTile(context, "46 - Al-Ahqaf"),
                buildSurahTile(context, "47 - Muhammad"),
                buildSurahTile(context, "48 - Al-Fath"),
                buildSurahTile(context, "49 - Al-Hujraat"),
                buildSurahTile(context, "50 - Qaf"),
                buildSurahTile(context, "51 - Adh-Dhariyat"),
                buildSurahTile(context, "52 - At-Tur"),
                buildSurahTile(context, "53 - An-Najm"),
                buildSurahTile(context, "54 - Al-Qamar"),
                buildSurahTile(context, "55 - Ar-Rahman"),
                buildSurahTile(context, "56 - Al-Waqi'a"),
                buildSurahTile(context, "57 - Al-Hadid"),
                buildSurahTile(context, "58 - Al-Mujadila"),
                buildSurahTile(context, "59 - Al-Hashr"),
                buildSurahTile(context, "60 - Al-Mumtahina"),
                buildSurahTile(context, "61 - As-Saff"),
                buildSurahTile(context, "62 - Al-Jumu'a"),
                buildSurahTile(context, "63 - Al-Munafiqun"),
                buildSurahTile(context, "64 - At-Taghabun"),
                buildSurahTile(context, "65 - At-Talaq"),
                buildSurahTile(context, "66 - At-Tahrim"),
                buildSurahTile(context, "67 - Al-Mulk"),
                buildSurahTile(context, "68 - Al-Qalam"),
                buildSurahTile(context, "69 - Al-Haaqa"),
                buildSurahTile(context, "70 - Al-Ma'arij"),
                buildSurahTile(context, "71 - Nuh"),
                buildSurahTile(context, "72 - Al-Jinn"),
                buildSurahTile(context, "73 - Al-Muzzammil"),
                buildSurahTile(context, "74 - Al-Muddathir"),
                buildSurahTile(context, "75 - Al-Qiyama"),
                buildSurahTile(context, "76 - Al-Insan"),
                buildSurahTile(context, "77 - Al-Mursalat"),
                buildSurahTile(context, "78 - An-Naba"),
                buildSurahTile(context, "79 - An-Nazi'at"),
                buildSurahTile(context, "80 - Abasa"),
                buildSurahTile(context, "81 - At-Takwir"),
                buildSurahTile(context, "82 - Al-Infitar"),
                buildSurahTile(context, "83 - Al-Mutaffifin"),
                buildSurahTile(context, "84 - Al-Inshiqaq"),
                buildSurahTile(context, "85 - Al-Buruj"),
                buildSurahTile(context, "86 - At-Tariq"),
                buildSurahTile(context, "87 - Al-Ala"),
                buildSurahTile(context, "88 - Al-Ghashiyah"),
                buildSurahTile(context, "89 - Al-Fajr"),
                buildSurahTile(context, "90 - Al-Balad"),
                buildSurahTile(context, "91 - Ash-Shams"),
                buildSurahTile(context, "92 - Al-Layl"),
                buildSurahTile(context, "93 - Ad-Duha"),
                buildSurahTile(context, "94 - Ash-Sharh"),
                buildSurahTile(context, "95 - At-Tin"),
                buildSurahTile(context, "96 - Al-Alaq"),
                buildSurahTile(context, "97 - Al-Qari'ah"),
                buildSurahTile(context, "98 - At-Takathur"),
                buildSurahTile(context, "99 - Al-Asr"),
                buildSurahTile(context, "100 - Al-Humazah"),
                buildSurahTile(context, "101 - Al-Fil"),
                buildSurahTile(context, "102 - Quraish"),
                buildSurahTile(context, "103 - Al-Ma'un"),
                buildSurahTile(context, "104 - Al-Kawthar"),
                buildSurahTile(context, "105 - Al-Kafirun"),
                buildSurahTile(context, "106 - An-Nasr"),
                buildSurahTile(context, "107 - Al-Massad"),
                buildSurahTile(context, "108 - Quraish"),
                buildSurahTile(context, "109 - Al-Falaq"),
                buildSurahTile(context, "110 - An-Nas"),
                buildSurahTile(context, "111 - Al-Massad"),
                buildSurahTile(context, "112 - Al-Ikhlas"),
                buildSurahTile(context, "113 - Al-Falaq"),
                buildSurahTile(context, "114 - An-Nas"),
                SizedBox(height: 10),
              ],
            )),
      ),
    );
  }

  Widget buildSurahTile(BuildContext context, String text) {
    return GestureDetector(
      onTap: () {
        openAudioPlayerDialog(text);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 25),
              Expanded(
                child: Text(
                  text,
                  style: GoogleFonts.ptSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

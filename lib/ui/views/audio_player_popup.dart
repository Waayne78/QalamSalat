import 'package:Qalam/ui/app/app_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AudioPlayerPage extends StatefulWidget {
  final List<String> surahList; // Liste des noms de sourates
  final String surahName;

  AudioPlayerPage({required this.surahList, required this.surahName});

  @override
  _AudioPlayerPageState createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  int currentSurahIndex = 0; // Position actuelle dans la liste
  bool isPlaying = false;
  bool isFavorite = false;

  // Fonction pour inverser l'état du bouton favoris
  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  // Fonction pour inverser l'état du bouton lecture/pause
  void togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  // Icône de lecture ou pause en fonction de l'état isPlaying
  Icon playPauseIcon() {
    return isPlaying
        ? Icon(
            Icons.pause_rounded,
            size: 60.0,
            color: Colors.black,
          )
        : Icon(
            Icons.play_arrow_rounded,
            size: 60.0,
            color: Colors.black,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.surahName,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.darkColor,
            )),
        backgroundColor: AppTheme.lightColor,
        elevation: 0,
          leading: IconButton(
          onPressed: () {
            AutoRouter.of(context).pop();
          },
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black, size: 45),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Zone pour afficher les détails de la sourate
            SizedBox(height: 16.0),
            // Icône de la sourate (vous pouvez personnaliser l'icône)
            SizedBox(height: 16.0),
            // Barre de progression (vous pouvez personnaliser son aspect)
            SizedBox(height: 200.0),
            Column(
              children: [
                Text(
                  '2:30 / 14:07', // Remplacez cette valeur par la durée actuelle
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                LinearProgressIndicator(
                  value:
                  
                      0.2, // Modifiez cette valeur pour la progression actuelle
                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.darkColor),
                  backgroundColor: AppTheme.primaryColor,
                ),
              ],
            ),
            SizedBox(height: 16.0),
            // Boutons de favoris, lecture/pause, arrêt, saut précédent et saut suivant
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, 
              children: <Widget>[
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 60.0,
                      color: isFavorite ? AppTheme.darkColor : Colors.black,
                    ),
                    onPressed: () {
                      // Action pour ajouter ou supprimer de la liste de favoris
                      toggleFavorite();
                    },
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.skip_previous_rounded,
                      size: 60.0,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: playPauseIcon(),
                    onPressed: () {
                      // Action pour démarrer ou arrêter la lecture
                      togglePlayPause();
                    },
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.skip_next_rounded,
                      size: 60.0,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

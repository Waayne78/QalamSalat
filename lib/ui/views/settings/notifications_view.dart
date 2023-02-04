import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/ui/app/app_theme.dart';

class NotificationsView extends ConsumerWidget {
  const NotificationsView({
    super.key,
  });

  Widget buildNotifTile(IconData icone, String text) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(
            color: AppTheme.primaryColor,
            borderRadius: BorderRadius.circular(28)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icone,
                size: 20,
              ),
              SizedBox(width: 20),
              Expanded(
                child: Text(text.toUpperCase(),
                    style: GoogleFonts.ptSans(
                        fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              Switch(
                activeColor: AppTheme.darkColor,
                onChanged: (bool value) {},
                value: true,
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: AppTheme.lightColor,
        appBar: AppBar(
          backgroundColor: AppTheme.lightColor,
          centerTitle: true,
          title: Text('Qalam',
              style: GoogleFonts.cormorantGaramond(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkColor,
              )),
          elevation: 0,
        ),
        body: Container(
          child: Opacity(opacity:0.6 ,
          
            child: IgnorePointer(
                child: Container(
          padding: const EdgeInsets.all(10),
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("notifications".toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: AppTheme.darkColor)),
                        SizedBox(height: 15),
                Text("( Bientôt disponible )",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: AppTheme.darkColor)),
                SizedBox(height: 25),
                buildNotifTile(Icons.notifications, "SUBH"),
                buildNotifTile(Icons.notifications, "DHUHR"),
                buildNotifTile(Icons.notifications, "ASR"),
                buildNotifTile(Icons.notifications, "MAGHRIB"),
                buildNotifTile(Icons.notifications, "ISHA"),
                 SizedBox(height:15),
              ],
             
            ),
            
          ),
        )))));
        
  }
}

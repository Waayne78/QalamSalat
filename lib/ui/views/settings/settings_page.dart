import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Qalam/ui/app/app_router.gr.dart';
import 'package:Qalam/ui/app/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({
    super.key,
  });

  Widget buildSettingsTile(IconData icone, String text, Function() onTap) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: AppTheme.primaryColor,
            borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
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
              IconButton(
                  onPressed: onTap,
                  icon: Icon(Icons.arrow_forward_ios_sharp, size: 20)),
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
        leading: IconButton(
          onPressed: () {
            AutoRouter.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("paramètres".toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: AppTheme.darkColor,
                )),
            SizedBox(height: 30),
           // buildSettingsTile(Icons.location_on_outlined, "Localisation", () {
            //  AutoRouter.of(context).push(LocationRoute());
          //  }),
            buildSettingsTile(Icons.favorite_outline, "évaluer l'application",
                () async {
              const repoUrl = "https://github.com/Wayne78190/QalamSalat#readme";
              await launchUrl(Uri.parse(repoUrl));
            }),
            buildSettingsTile(Icons.copyright_rounded, "à propos de Qalam",
                () async {
              const repoUrl = "https://github.com/Wayne78190/QalamSalat#readme";
              await launchUrl(Uri.parse(repoUrl));
            }),
            buildSettingsTile(Icons.attach_money_sharp, "donner à la mosquée",
                () async {
              const repoUrl = "https://avecc78.org/faire-un-don/";
              await launchUrl(Uri.parse(repoUrl));
            }),
            SizedBox(height: 350)
          ],
        ),
      ),
    );
  }
}

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:Qalam/ui/app/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class QiblahView extends StatefulWidget {
  const QiblahView({Key? key});

  @override
  State<QiblahView> createState() => _QiblahViewState();
}

class _QiblahViewState extends State<QiblahView>
    with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? _animationController;
  double begin = 0.0;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation = Tween(begin: 0.0, end: 0.0).animate(_animationController!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.lightColor,
        appBar: AppBar(
          backgroundColor: AppTheme.lightColor,
          title: Text(
            'Qalam',
            style: GoogleFonts.cormorantGaramond(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppTheme.darkColor,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: StreamBuilder(
          stream: FlutterQiblah.qiblahStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                !snapshot.hasData) {
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: AppTheme.lightColor,
                ),
              );
            }

            final qiblahDirection = snapshot.data;
            if (qiblahDirection == null) {
              return Center(
                child: Text(
                  'Impossible de détecter la direction de la Qibla',
                  style: TextStyle(
                    color: AppTheme.darkColor,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }

            animation = Tween(
              begin: begin,
              end: (qiblahDirection.qiblah * (pi / 180) * -1),
            ).animate(_animationController!);
            begin = (qiblahDirection.qiblah * (pi / 180) * -1);
            _animationController!.forward(from: 0);

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${qiblahDirection.direction.toInt()}°",
                    style: TextStyle(
                      color: AppTheme.darkColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    height: 300,
                    child: AnimatedBuilder(
                      animation: animation!,
                      builder: (context, child) => Transform.rotate(
                        angle: animation!.value,
                        child: Image.asset('assets/images/qiblah.png'),
                      ),
                    ),
                  ),
                  SizedBox(height: 35),
                  ElevatedButton(
                    onPressed: () {
                      _animationController!.reset();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20), 
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Text('Recalibrer la direction'),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

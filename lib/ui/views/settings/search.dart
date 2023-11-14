import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../app/app_theme.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController _searchController = TextEditingController();
  List<String> nearbyCities = [];
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {}
  }

  void _getNearbyCities(String searchText) async {
    if (_currentPosition != null) {
      try {
        final url =
            'https://nominatim.openstreetmap.org/search?format=json&city=$searchText&limit=1';
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final data = json.decode(response.body) as List<dynamic>;
          final cities = data.map<String>((item) {
            final displayName = item['display_name'] as String;
            final cityParts = displayName.split(',');
            final cityName = cityParts[0].trim();
            final postalCode = cityParts[5].trim();
            return '$cityName , $postalCode';
          }).toList();

          setState(() {
            nearbyCities = cities;
          });
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  void _filterCities(String searchText) {
    _getNearbyCities(searchText);
  }

  void _showCityPopup(String cityName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ville sélectionnée'),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20.0), // Définir le rayon des coins ici
          ),
          backgroundColor: AppTheme.primaryColor,
          content: Text('Vous avez sélectionné la ville : $cityName'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
                Navigator.of(context).pop(); // Ferme le menu
              },
            ),
          ],
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
        title: Text(
          'Qalam®',
          style: GoogleFonts.cormorantGaramond(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkColor,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterCities,
              decoration: InputDecoration(
                hintText: 'Rechercher...',
                prefixIcon: Icon(
                  Icons.search,
                  color: AppTheme.darkColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: AppTheme.darkColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: AppTheme.darkColor,
                  ),
                ),
              ),
              cursorColor: AppTheme.darkColor,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: nearbyCities.length,
              itemBuilder: (context, index) {
                final city = nearbyCities[index];
                return ListTile(
                  title: Text(city),
                  onTap: () {
                    _showCityPopup(city);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

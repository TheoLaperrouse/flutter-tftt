import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_tftt/models/live.dart';
import 'package:flutter_tftt/models/player.dart';
import 'package:flutter_tftt/models/team.dart';
import 'package:flutter_tftt/utils/globals.dart' as globals;

// screens
import 'package:flutter_tftt/screens/home.dart';
import 'package:flutter_tftt/screens/ordering.dart';
import 'package:flutter_tftt/screens/events.dart';
import 'package:flutter_tftt/screens/pictures.dart';
import 'package:flutter_tftt/screens/profile.dart';
import 'package:flutter_tftt/screens/settings.dart';
import 'package:flutter_tftt/screens/tablebooking.dart';
import 'package:flutter_tftt/screens/teams.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  await initializeDateFormatting();
  await initSettings();
  await initPlayer();
  await initLive();
  await initTeams();
  //initializeNotification();
  runApp(ApplicationTFTT());
}

Future<void> initSettings() async {
  await Settings.init(
    cacheProvider: SharePreferenceCache(),
  );
}

Future<void> initPlayer() async {
  await fetchPlayer(Settings.getValue<String>('numLicence', '3524012'))
      .then((result) {
    globals.player = result;
  });
}

Future<void> initTeams() async {
  await fetchTeams().then((result) {
    globals.teams = result;
    globals.teams.forEachIndexed(
        (index, team) => globals.teamSettings[index.toString()] = team.nom);
  });
}

class ApplicationTFTT extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Application TFTT",
        debugShowCheckedModeBanner: false,
        initialRoute: "/home",
        routes: <String, WidgetBuilder>{
          "/home": (BuildContext context) => new Home(),
          // "/calculator": (BuildContext context) => new Calculator(),
          "/profile": (BuildContext context) => new Profile(),
          "/events": (BuildContext context) => new Events(),
          "/ordering": (BuildContext context) => new OrderingForm(),
          "/settings": (BuildContext context) => new SettingsPage(),
          "/tablebooking": (BuildContext context) => new TableBooking(),
          "/teams": (BuildContext context) => new Teams(),
          "/picturealbum": (BuildContext context) => new PictureAlbum(),
        });
  }
}

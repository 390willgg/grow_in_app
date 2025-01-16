import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grow_in_app/utils/common/helpers/observer_helper.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';

import 'app.dart';
import 'firebase_options.dart';
import 'injection.dart' as di;

var logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
  ),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseDatabase.instance.setPersistenceEnabled(true);
  
  await Hive.initFlutter();
  await di.init();

  Bloc.observer = ObserverHelper();
  runApp(App());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         BlocProvider<AuthBloc>(
//           create: (_) => di.sl<AuthBloc>()..add(CheckLogInEvent()),
//         )
//       ],
//       child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
//         if (state is SignedInPageState) {
//           return const MaterialApp(
//             title: "flutter demo",
//             debugShowCheckedModeBanner: false,
//             home: HomePage(),
//           );
//         } else {
//           return const MaterialApp(
//             title: "flutter demo",
//             debugShowCheckedModeBanner: false,
//             home: SignUpPage(),
//           );
//         }
//       }),
//     );
//   }
// }

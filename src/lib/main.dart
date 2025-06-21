import 'dart:ui';
//import 'package:web/web.dart';

import 'package:app02_mob_web/router/router.dart';
import 'package:app02_mob_web/state/bloc/auth_bloc.dart';
import 'package:app02_mob_web/state/bloc/hwdict_bloc.dart';
import 'package:app02_mob_web/state/bloc/hwlist_bloc.dart';
import 'package:app02_mob_web/state/bloc/pglist_bloc.dart';
import 'package:app02_mob_web/theme/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget _buildRunnableApp({
  required bool isWeb,
  required double webAppWidth,
  required double webAppHeight,
  required Widget app,
}) {
  if (!isWeb) {
    return app;
  }

  return Center(
    child: ClipRect(
      child: SizedBox(
        height: webAppHeight,
        width: webAppWidth,
        child: 
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                    color: Colors.blueGrey,
                    width: 10.0
                )
            ),

            child: app,
            ),
      ),
    ),
  );
}


void main() {
  //runApp(const MyApp());
    //final div = document.querySelector('div')!;
    //div.textContent = 'Flutter Test WebAssembly WEB-Application. Use only Chromium Web Browser... ';
    final runnableApp = _buildRunnableApp(
    isWeb: kIsWeb,
    webAppWidth: 480.0,
    webAppHeight: 800.0,
    app: const MyApp(),
  );

  runApp(runnableApp);

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (BuildContext context) => AuthBloc(),
          ),
          BlocProvider<HwdictBloc>(
            create: (BuildContext context) => HwdictBloc(context),
          ),
          BlocProvider<HwlistBloc>(
            create: (BuildContext context) => HwlistBloc(context),
          ),
          BlocProvider<PglistBloc>(
            create: (BuildContext context) => PglistBloc(context),
          ),
        ],
        child: MaterialApp(
          scrollBehavior: MyCustomScrollBehavior(),
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: theme1,
          routes: routes,
          //home: const Home(title: 'Мини-ITIL'),
        ));
  }
}

// class Home extends StatefulWidget {
//   const Home({super.key, required this.title});

//   final String title;

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthBloc, AuthState>(
//       listener: (context, authstate) {   },
//       builder: (context, authstate)  {
//         return Scaffold(
          
//           appBar: AppBar(
//             backgroundColor: Theme.of(context).colorScheme.primary,
//             title: Text(widget.title),
//             actions: [
//               if (authstate is Authenticated) IconButton(
//                 onPressed: () {
//                   BlocProvider.of<AuthBloc>(context).add(SignOut());
//                 }, 
//               icon: const Icon(Icons.logout)
//               ),
//             ],
//           ),
//           body: 
//             authstate is Authenticated ?
//             const MainMenu() : const LoginScreen(),
//         );
//       },
//     );
//   }
// }

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
  }

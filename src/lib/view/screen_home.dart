import 'dart:ui';

import 'package:app02_mob_web/state/bloc/auth_bloc.dart';
import 'package:app02_mob_web/view/body_login.dart';
import 'package:app02_mob_web/view/body_menu.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, authstate) {   },
      builder: (context, authstate)  {
        return Scaffold(
          
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Text(widget.title),
            actions: [
              if (authstate is Authenticated) TextButton(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(SignOut());
                }, 
                child: Text('Выход', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),),
              //icon: const Icon(CupertinoIcons.eject),//Text('Выход'),//const Icon(Icons.logout)
              ),
            ],
          ),
          body: 
            authstate is Authenticated ?
            const MainMenu() : const LoginScreen(),

          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerFloat,
          // floatingActionButton: FloatingActionButton.extended(
          //   backgroundColor: Theme.of(context).colorScheme.primary,
          //   foregroundColor: Theme.of(context).colorScheme.onPrimary,
          //   onPressed: () {},
          //   tooltip: 'Increment',
          //   label: const Text('Показать 230'), //const Icon(Icons.add),
          // ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

//import 'package:app01/state/bloc/hwdict_bloc.dart';
//import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
  }
  
class _LoginScreenState extends State<LoginScreen> {

  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {

  return 

  SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
      child: Center(child:
        SizedBox(
          width: 360,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 200, width: 300, 
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Icon(
                          //     Icons.account_circle, 
                          //     size: 60, 
                          //     color: Theme.of(context).colorScheme.primary,
                          //       ),
                          
                           Text('Мини-ITIL', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 32, color: Theme.of(context).colorScheme.primary ), ),
                              
                        ],
                      )),
                  ),
                
                const SizedBox(height: 30),
                
                  //const Text("Login",style: TextStyle(fontWeight: FontWeight.w800, fontSize: 38, ), ),
                
             SizedBox(
                      width: 320,//MediaQuery.of(context).size.width > 600  ? 400 :   MediaQuery.of(context).size.width / 1.3,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(labelText: "Email"),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regex = RegExp(pattern.toString());
                              if (!regex.hasMatch(value!)) {
                                return 'Введине корректный Email...';
                              }
                              else {
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            controller: passwordController,
                            decoration: const InputDecoration(labelText: "Пароль"),
                            validator: (value) {
                              return value!.length < 4
                                  ? "Длина пароля не менее 4 символов..."
                                  : null;
                            },
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),
          
          const SizedBox(height: 30),
          Column(
                    children: <Widget>[
                
                      FilledButton.icon(
                        onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(SignIn(emailController.text, passwordController.text));
                          }
                        },
                        //icon: const Icon(Icons.person_2),
                        label: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Вход', style:  TextStyle(fontSize: 24), ),
                        ),
                        iconAlignment: IconAlignment.start,
                        ),
                            
          const SizedBox(height: 40),
                
                      
          Row( 
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment:  MainAxisAlignment.center,
                        children: <Widget>[
                          TextButton(
                            //icon: const Icon(CupertinoIcons.person),//const Icon(Icons.person_2_outlined), 
                            child: const Text('Tom'),
                            onPressed: () { 
                            emailController.text    = 'tom@gmail.com';
                            passwordController.text = '1qaz!QAZ1qaz';
                          },),
                          const SizedBox(width: 20,),
                          TextButton(
                            //icon: const Icon(CupertinoIcons.person), 
                            child: const Text('Ivan'),
                            onPressed: () { 
                            emailController.text    = 'ivan@mail.ru';
                            passwordController.text = 'Topaz108_Chernov';
                          },)
                        ]
                      ),
          const SizedBox(height: 400),      
                    ],
                  ),
                
          Column(
            children: [
              Divider(),
              Container(
                padding: EdgeInsets.fromLTRB(20,5,20,20),
                child: Center(child: Text(getPlatformInfo(), style: TextStyle(fontSize: 12), textAlign: TextAlign.justify,)),
              ),
            ],
          )
          ,
                
                
                ],
              ),
            ),
        ),

        ),
    );

//  );


  }

  String getPlatformInfo() {
    String platform  = '';
    const  isWebJS   = bool.fromEnvironment('dart.library.js_util');
    const  isWebWasm = bool.fromEnvironment('dart.tool.dart2wasm');

    if (isWebJS || isWebWasm) {
      platform = isWebWasm ? 'WEB (WebAssembly)' : 'WEB (JavaScript)';
    } else {
      platform = '${Platform.operatingSystem}: ${Platform.operatingSystemVersion}';
    }
    return 'Платформа $platform';
  }


}

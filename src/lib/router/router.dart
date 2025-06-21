


import 'package:app02_mob_web/view/screen_details.dart';
import 'package:app02_mob_web/view/screen_home.dart';
import 'package:app02_mob_web/view/screen_hwlist.dart';
//import 'package:graphql/client.dart';

final routes = {
  '/'      : (context)    =>  const Home(title: "Мини-ITIL",) ,
  '/list'  : (context)    =>  const HwList() ,
  '/detail': (context)    =>  const HwlistDetails() ,
};

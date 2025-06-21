//import 'package:carousel_slider/carousel_controller.dart';
import 'package:app02_mob_web/state/bloc/hwdict_bloc.dart';
import 'package:app02_mob_web/state/bloc/hwlist_bloc.dart';
import 'package:app02_mob_web/state/bloc/pglist_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {

    final hwlBloc = BlocProvider.of<HwlistBloc>(context);
    final pglBloc = BlocProvider.of<PglistBloc>(context);

    
    if (BlocProvider.of<HwdictBloc>(context).state is !HwdictLoaded) {
      BlocProvider.of<HwdictBloc>(context).add(HwdictLoad());
    }

    return BlocConsumer<HwdictBloc, HwdictState>(
      listener: (context, dictstate) {  
        if (dictstate is HwdictLoaded) {
          //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Установите параметры отбора и нажмите "Список СВТ".')));
        }  
      },
      builder:  (context, dictstate) {


      if (dictstate is HwdictInitial || dictstate is HwdictLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (dictstate is HwdictLoaded) {
        return Center(
          child: SizedBox(
            width: 600,
            child: ListView(
              padding: const EdgeInsets.all(16), 
              children: [
              const SizedBox(height: 20),

              sliderPanel(dictstate),
              const SizedBox( height: 10, ),
              statePanel(dictstate),
              const SizedBox( height: 20, ),
              const Divider(),
              const SizedBox( height: 20, ),
              UnconstrainedBox(
                  child: SizedBox(
                    width: 200,
                    child: FloatingActionButton.extended(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      onPressed: () {

                      //debugPrint('typeChoice=${dictstate.store.typeChoice.toString()}');
                      //debugPrint('stateChoice=${dictstate.store.stateChoice.toString()}');    
                      //
                      //      
                      pglBloc.state.store.searchController.text = '';
                      hwlBloc.state.store.searchFilter = false;
                      hwlBloc.state.store.searchstr = '';
                      //
                      hwlBloc.add(HwlistLoad(
                        stateFilter: dictstate.store.stateChoice.isNotEmpty,
                        stateIds: dictstate.store.stateChoice.toList(),
                        typeFilter: dictstate.store.typeChoice.isNotEmpty,
                        typeIds: dictstate.store.typeChoice.toList(),
                        searchFilter: hwlBloc.state.store.searchFilter,
                        searchstr: hwlBloc.state.store.searchstr,
                        // order: hwlBloc.state.store.order,
                        )
                      );



                      pglBloc.state.store.setListReverse = false;
                      pglBloc.state.store.setListCount   = 20;

                      Navigator.of(context).pushNamed('/list');

                      },
                      tooltip: 'Переход к списку СВТ',
                      label: const Text('Список СВТ'), //const Icon(Icons.add),
                    ),
                  ),
                ),
            ]),
          ),
        );
      }
      return const SizedBox();
      }
    );
  }

//
//
//
Widget sliderPanel(HwdictState dictstate) {
  return Column(
    children: [
              ListTile(
                title: SizedBox(
                  height: 160,
                  child: CarouselSlider.builder(
                    carouselController: dictstate.store.sliderController,
                    itemCount: dictstate.store.getStateKeys.length + 1,
                    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) 
                    {
                      if (itemIndex == 0) {
                        return Card(
                        color: Theme.of(context).colorScheme.primaryContainer, //Colors.primaries[itemIndex % Colors.primaries.length],//Colors.blueAccent ,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: const SizedBox(
                              height: 100,
                              child: Text('Средства вычислительной техники',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            subtitle: Text('Всего: ${dictstate.store.getHwlistTotal}'),
                            //trailing: Text('${dictstate.store.getHwlistTotal}',),
                            //titleAlignment: ListTileTitleAlignment.top,
                          ),
                        ),
                      );
                      } else {
                      final nSlide = itemIndex - 1;
                      return Card(
                        color: Theme.of(context).colorScheme.inversePrimary, //Colors.primaries[itemIndex % Colors.primaries.length],//Colors.blueAccent ,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: SizedBox(
                              height: 100,
                              child: Text(dictstate.store.getTypeVals[nSlide],
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            subtitle: Text('Всего: ${dictstate.store.getTypeCounts[nSlide]}'),
                            //trailing: Text('${dictstate.store.getTypeCounts[nSlide]}'),
                            //titleAlignment: ListTileTitleAlignment.top,
                            
                          ),
                        ),
                      );
                      }
                    },
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        dictstate.store.typeChoice = {};
                        if (index > 0) {
                          dictstate.store.typeChoice.add(dictstate.store.getTypeKeys[index-1]);
                        } 
                        
                        setState(() {
                          dictstate.store.typeChoicePos = index.toDouble();
                        }); 

                      },
                      autoPlay: false,
                      enlargeCenterPage: false,
                      viewportFraction: 1,
                      aspectRatio: 16 / 9,
                      initialPage: 0,
                    ),
                  ),
                ),
              ),
              ListTile(
                  title: DotsIndicator(
                    dotsCount: dictstate.store.getTypeKeys.length + 1,
                    position:  dictstate.store.typeChoicePos,
                    ),
                  leading: IconButton(
                    onPressed: () {
                      dictstate.store.sliderController.previousPage();
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      dictstate.store.sliderController.nextPage();
                    },
                    icon: const Icon(Icons.arrow_forward_ios),
                  )),

    ],
  );
}
//
//
//
Widget statePanel(HwdictState dictstate) {
  return Column(children: [
    for ( var i=0,
          choices=dictstate.store.stateChoice,
          keys=dictstate.store.getStateKeys,
          vals=dictstate.store.getStateVals;
          i < keys.length; i++ )
    Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      child: SwitchListTile(
        title: Text(vals[i], style: const TextStyle(fontWeight: FontWeight.bold),),
        value: choices.contains(keys[i]), 
        onChanged: (value) {setState(() { 
          choices.contains(keys[i]) ? choices.remove(keys[i]) : choices.add(keys[i]);
          });
        },
      ),
    ),      
  ],);
}

}

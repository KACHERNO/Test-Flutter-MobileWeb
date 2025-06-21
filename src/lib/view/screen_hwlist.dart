import 'package:app02_mob_web/state/bloc/hwdict_bloc.dart';
import 'package:app02_mob_web/state/bloc/hwlist_bloc.dart';
import 'package:app02_mob_web/state/bloc/pglist_bloc.dart';
//import 'package:app02_mob_web/view/dialog_hwlist_detail.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HwList extends StatefulWidget {
  const HwList({super.key});

  @override
  State<HwList> createState() => _HwListState();
}

class _HwListState extends State<HwList> {

  int loadMoreCount = 10;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HwlistBloc, HwlistState>(
      listener: (context, hwlstate) {},
      builder: (context, hwlstate) {
        final hwlBloc = BlocProvider.of<HwlistBloc>(context);
        final pglBloc = BlocProvider.of<PglistBloc>(context);
        //final hwdBloc = BlocProvider.of<HwdictBloc>(context);
        final searchFocusNode = FocusNode();

        if (hwlstate is HwlistInitial ) {  hwlBloc.add(HwlistLoad());         }

        //hwlBloc.add(HwlistLoad());
        //pglBloc.state.store.setListReverse = false;
        //pglBloc.state.store.setListCount   = 50;


        return BlocConsumer<PglistBloc, PglistState>(
          listener: (context, pglstate) {      },
          builder:  (context, pglstate) {

            return Scaffold(
              appBar: AppBar(
                title: const Text(''),
                actions: [
                  if (hwlstate is HwlistLoaded) Text('${pglBloc.state.store.getListCount > hwlstate.store.getRowsCount ? hwlstate.store.getRowsCount : pglBloc.state.store.getListCount} / ${hwlstate.store.getTotal} '),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                child: Column(
                  children: [
                    //
                    // SEARCH BAR
                    //
                    TextField(
                      focusNode: searchFocusNode,
                      controller: pglstate.store.searchController,
                      autofocus: false,
                      textInputAction: TextInputAction.search,
                      onEditingComplete: () {
                        searchFocusNode.unfocus();
                        //SystemChannels.textInput.invokeMethod('TextInput.hide');
                        startSearch(context);
                        },
                      //onSubmitted: (str) {debugPrint('str=$str'); },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        //prefixIcon: const Icon(Icons.filter_alt),
                        border: const OutlineInputBorder(),
                        hintText: 'Поиск',
                        suffixIcon: 

                          IconButton(onPressed: () {clearSearch(context);}, icon: const Icon(Icons.clear, color: Colors.red,))

                          // ToggleButtons(
                          //   renderBorder: false,
                          //   isSelected: const [false, false],
                          //   children: const [Icon(Icons.clear,color: Colors.red,), Icon(Icons.search) ],
                          //   onPressed: (int index) {
                          //     if (index == 0) { clearSearch(context); }
                          //     if (index == 1) { startSearch(context); }
                          //   }),



                      ),
                    ),
                    Expanded( child: 
                    //
                    // LIST
                    //
                ( hwlstate is HwlistInitial || hwlstate is HwlistLoading ) ?
                  const Center(child: CircularProgressIndicator()) 
                  :
                  ListView.separated(
                    //
                    reverse: pglBloc.state.store.getListReverse,
                    //
                    itemCount: 
                      pglBloc.state.store.getListCount > hwlstate.store.getRowsCount
                      ? hwlstate.store.getRowsCount + 1
                      : pglBloc.state.store.getListCount + 1,
                    separatorBuilder: (BuildContext context, int index) =>  const Divider(height: 4),
                    itemBuilder: (context, index) {
                      final rCount = pglBloc.state.store.getListCount >  hwlstate.store.getRowsCount
                          ? hwlstate.store.getRowsCount
                          : pglBloc.state.store.getListCount;
                      final rTotal = hwlstate.store.getTotal;
                      final rIndex = rCount - /*1 -*/ index;
                      //
                      final ind = pglBloc.state.store.getListReverse ? rIndex : index;
                      //
//debugPrint('rCount=$rCount, rTotal=$rTotal, rIndex=$rIndex, ind=$ind ');                      
                      if (ind == rCount) {
                        return rTotal > rCount
                            ? Center(
                                child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0, 20, 0, 20),
                                child: FilledButton(
                                  child: Text(
                                      "Еще ${rTotal - rCount >= loadMoreCount ? loadMoreCount : rTotal - rCount} из ${rTotal - rCount} ..."),
                                  onPressed: () /*async*/ {
                                    if ((rCount + loadMoreCount) >  hwlstate.store.getRowsCount) {
                                      hwlBloc.add(HwlistLoadMore(50));
                                    }
                                    pglBloc.add(PglistRebuild(addCount: loadMoreCount, reverse: true));
                                    //await pglBloc.stream.firstWhere((state) => state is PglistBuilded,);
                                    //pglBloc.state.store.scrollController.jumpTo(pglBloc.state.store.scrollController.position.maxScrollExtent);

                                  },
                                ),
                              ))
                            : const SizedBox(
                                width: 40,
                                height: 40,
                              );
                      }
                  
                      final row = hwlstate.store.getRows[ind];
                      //
                      final hwInvnum = row['hw_invnum'];
                      final hwRoom   = row['hw_room'] ?? '';
                      final stateId  = row['hw_state_id'];
                      final cfgiDesc = row['cfgi_desc'];
                      //final typeDesc = row['type_desc'];
                      //final deptDesc = row['dept_desc'];
                      //final stateDesc = row['state_desc'];
                      return ListTile(
                          titleAlignment: ListTileTitleAlignment.center,
                          //isThreeLine: true,
                          dense: true,
                          title: Text(
                              '$hwInvnum${stateId as int != 1 ? "*" : ""}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary)),
                          subtitle: Text('$cfgiDesc'),
                          leading: Container(
                            //color: Theme.of(context).colorScheme.primary ,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer,
                              //border: Border.all( width: 0.5 ),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(12.0)),
                            ),
                  
                            child: SizedBox(
                              width: 40,
                              child: Center(
                                child: Text('$hwRoom',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondaryContainer)),
                              ),
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Theme.of(context).dividerColor,
                            ),
                            onPressed: () {
                              pglBloc.state.store.setListIndex = ind;
                              Navigator.of(context).pushNamed('/detail');

                              // showDialog(
                              //     context: context,
                              //     builder: (BuildContext context) {
                              //       return HwlistDetailDialog(
                              //         index: ind,
                              //       );
                              //     });
                            },
                          ),
                          contentPadding:
                              const EdgeInsets.only(left: 20, right: 20));
                    },
                  ),
                    //          
                    // END LIST
                    //
                    )
                  ],
                ),
              ),
            );
         }
       );
      },
    );
  }

//
//
//
void clearSearch(BuildContext context)
{
  final hwlBloc   = BlocProvider.of<HwlistBloc>(context);
  final pglBloc   = BlocProvider.of<PglistBloc>(context);
  final hwdBloc   = BlocProvider.of<HwdictBloc>(context);
  var searchTtext = pglBloc.state.store.searchController.text;


  if ( searchTtext.isNotEmpty) {
    pglBloc.state.store.searchController.text = '';
  }
  //
  if (hwlBloc.state.store.searchFilter) {
  
    pglBloc.state.store.setListReverse = false;
    pglBloc.state.store.setListCount   = 50;
    hwlBloc.state.store.searchFilter = false;
    hwlBloc.state.store.searchstr = '';
  
    hwlBloc.add(HwlistLoad(
    stateFilter: hwdBloc.state.store.stateChoice.isNotEmpty,
    stateIds: hwdBloc.state.store.stateChoice.toList(),
    typeFilter: hwdBloc.state.store.typeChoice.isNotEmpty,
    typeIds: hwdBloc.state.store.typeChoice.toList(),
    searchFilter: hwlBloc.state.store.searchFilter,
    searchstr: hwlBloc.state.store.searchstr,
    // order: hwlBloc.state.store.order,
    )
  );

  }
}
//
//
//
void startSearch(BuildContext context)
{
  final hwlBloc   = BlocProvider.of<HwlistBloc>(context);
  final pglBloc   = BlocProvider.of<PglistBloc>(context);
  final hwdBloc   = BlocProvider.of<HwdictBloc>(context);
  var searchTtext = pglBloc.state.store.searchController.text; 

  if ( searchTtext.isNotEmpty) {

    pglBloc.state.store.setListReverse = false;
    pglBloc.state.store.setListCount   = 50;

    if (!searchTtext.contains('%') && !searchTtext.contains('_')) {
      searchTtext = '%$searchTtext%';  
    }
    pglBloc.state.store.searchController.text = searchTtext;  
    hwlBloc.state.store.searchFilter = true;
    hwlBloc.state.store.searchstr = searchTtext;

    //
    hwlBloc.add(HwlistLoad(
      stateFilter: hwdBloc.state.store.stateChoice.isNotEmpty,
      stateIds: hwdBloc.state.store.stateChoice.toList(),
      typeFilter: hwdBloc.state.store.typeChoice.isNotEmpty,
      typeIds: hwdBloc.state.store.typeChoice.toList(),
      searchFilter: hwlBloc.state.store.searchFilter,
      searchstr: hwlBloc.state.store.searchstr,
      // order: hwlBloc.state.store.order,
      )
    );
  }
}



}

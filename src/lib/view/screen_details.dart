import 'package:app02_mob_web/state/bloc/hwlist_bloc.dart';
import 'package:app02_mob_web/state/bloc/pglist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HwlistDetails extends StatefulWidget {
  const HwlistDetails({super.key});

  //BuildContext context;

  @override
  State<HwlistDetails> createState() => _HwlistDetailsState();
}

class _HwlistDetailsState extends State<HwlistDetails> {
  int _selectedIndex = 0;
  PageController? controller;

  // @override
  // void initState() {
  //   super.initState();
  //   controller = PageController(
  //       initialPage:
  //           BlocProvider.of<PglistBloc>(context).state.store.getListIndex);
  // }

  // @override
  // void dispose() {
  //   controller!.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    //final hwlBloc = BlocProvider.of<HwlistBloc>(context);
    final pglBloc = BlocProvider.of<PglistBloc>(context);
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<HwlistBloc, HwlistState>(
        listener: (context, hwlstate) {},
        builder: (context, hwlstate) {
        if (controller != null) {
          controller!.dispose();
        } 
          controller = PageController( initialPage: pglBloc.state.store.getListIndex);

          return 
          hwlstate is HwlistInitial || hwlstate is HwlistLoading ?
          const Center(child: CircularProgressIndicator(),)
          :
          PageView.builder(
            itemCount: hwlstate.store.getRowsCount,
            
            
            onPageChanged: (pn) {
              //debugPrint(pn.toString());
              setState(() {
                pglBloc.state.store.setListIndex = pn;
              });
            },
            controller: controller,
            itemBuilder: (context, index) {
              //controller!.jumpToPage(pglBloc.state.store.getListIndex);
              return _buildList();
            },
          );
        },
      ),
      bottomNavigationBar: BlocConsumer<HwlistBloc, HwlistState>(
        listener: (context, hwstate) {   },
        builder:  (context, hwstate) {
          return BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                  icon: Icon(Icons.arrow_back_ios), label: 'Назад'),
              BottomNavigationBarItem(
                  icon: pglBloc.state.store.getListIndex == hwstate.store.getRowsCount - 1 &&  _getLoadRemind() > 0
                      ? Text('Ещё ${_getLoadRemind()}')
                      : const Text(''),
                  label:
                      '${pglBloc.state.store.getListIndex + 1}/${hwstate.store.getRowsCount}'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.arrow_forward_ios), label: 'Вперед'),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            onTap: _onItemTapped,
          );
        },
      ),
    );
  }

//
//
//
  int _getLoadRemind() {
    final hwlBloc = BlocProvider.of<HwlistBloc>(context);
    const loadCount = 50;
    final loaded = hwlBloc.state.store.getRowsCount;
    final total = hwlBloc.state.store.getTotal;
    final remind = total - loaded;

    return remind > loadCount ? loadCount : remind;
  }

//
//
//
//
  void _onItemTapped(
    int index,
  ) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      _goPrev();
    }
    if (index == 1) {
      final hwlBloc = BlocProvider.of<HwlistBloc>(context);
      final pglBloc = BlocProvider.of<PglistBloc>(context);
      if (pglBloc.state.store.getListIndex ==
          hwlBloc.state.store.getRowsCount - 1) {
        final loadRemind = _getLoadRemind();
        if (loadRemind > 0) {
          //debugPrint('${pglBloc.state.store.getListIndex}');
          //controller!.jumpToPage(pglBloc.state.store.getListIndex);
          //debugPrint('${controller!.page}');
          hwlBloc.add(HwlistLoadMore(loadRemind));

        }
      }
    }
    if (index == 2) {
      _goNext();
    }
  }

//
  void _goNext() {
    final pglBloc = BlocProvider.of<PglistBloc>(context);
    final hwlBloc = BlocProvider.of<HwlistBloc>(context);
    setState(() {
      if (pglBloc.state.store.getListIndex <
          (hwlBloc.state.store.getRowsCount - 1)) {
        controller?.nextPage(
            duration: const Duration(milliseconds: 500), curve: Curves.linear);
      }
    });
  }

//
  void _goPrev() {
    final pglBloc = BlocProvider.of<PglistBloc>(context);
    setState(() {
      if (pglBloc.state.store.getListIndex > 0) {
        controller?.previousPage(
            duration: const Duration(milliseconds: 500), curve: Curves.linear);
      }
    });
  }

//
//
//
  Widget _buildList() {
    final hwlBloc = BlocProvider.of<HwlistBloc>(context);
    final pglBloc = BlocProvider.of<PglistBloc>(context);
    final titleStyle = TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.bold);

    return ListView(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      children: [
        Card(
          child: ListTile(
            
            dense: true,
            leading: _leadBadge('01'),
            titleTextStyle: titleStyle,
            title: Text(hwlBloc
                .state.store.getRows[pglBloc.state.store.getListIndex]['hw_id']),
            subtitle: const Text(
              'Актив (идентификатор)',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
        //const Divider(),
        Card(
          child: ListTile(
            dense: true,
            leading: _leadBadge('02'),
            titleTextStyle: titleStyle,
            title: Text(hwlBloc.state.store
                .getRows[pglBloc.state.store.getListIndex]['hw_invnum']),
            subtitle: const Text(
              'Инвентарный Номер',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
        //const Divider(),
        Card(
          child: ListTile(
            dense: true,
            leading: _leadBadge('03'),
            titleTextStyle: titleStyle,
            title: Text(hwlBloc.state.store
                    .getRows[pglBloc.state.store.getListIndex]['hw_prodnum'] ??
                ''),
            subtitle: const Text(
              'Заводской Номер',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
        //const Divider(),
        Card(
          child: ListTile(
            dense: true,
            leading: _leadBadge('04'),
            titleTextStyle: titleStyle,
            title: Text(hwlBloc.state.store
                .getRows[pglBloc.state.store.getListIndex]['type_desc']),
            subtitle: const Text(
              'Тип Актива',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
        //const Divider(),
        Card(
          child: ListTile(
            dense: true,
            leading: _leadBadge('05'),
            titleTextStyle: titleStyle,
            title: Text(hwlBloc.state.store
                .getRows[pglBloc.state.store.getListIndex]['cfgi_desc']),
            subtitle: const Text(
              'Конфигурационная Единица',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
        //const Divider(),
        Card(
          child: ListTile(
            dense: true,
            leading: _leadBadge('06'),
            titleTextStyle: titleStyle,
            title: Text(hwlBloc.state.store
                .getRows[pglBloc.state.store.getListIndex]['dept_desc']),
            subtitle: const Text(
              'Подразделение',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
        //const Divider(),
        Card(
          child: ListTile(
            dense: true,
            leading: _leadBadge('07'),
            titleTextStyle: titleStyle,
            title: Text(hwlBloc.state.store
                    .getRows[pglBloc.state.store.getListIndex]['hw_room'] ??
                ''),
            subtitle: const Text(
              'Комната',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
        //const Divider(),
        Card(
          child: ListTile(
            dense: true,
            leading: _leadBadge('08'),
            titleTextStyle: titleStyle,
            title: Text(hwlBloc.state.store
                    .getRows[pglBloc.state.store.getListIndex]['state_desc'] ??
                ''),
            subtitle: const Text(
              'Состояние',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
        //const Divider(),
      ],
    );
  }
  
  
  Widget _leadBadge(String code) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        height: 40,
        width: 40,
        child: Center(
          child: Text(code),),
      ),
    );
  }


  // Widget _badge(String code) {
  //   return Container(
  //     //color: Theme.of(context).colorScheme.primary ,
  //     padding: const EdgeInsets.all(4),
  //     decoration: BoxDecoration(
  //       color: Theme.of(context).colorScheme.surfaceContainer,
  //       //border: Border.all( width: 0.5 ),
  //       borderRadius: const BorderRadius.all(Radius.circular(12.0)),
  //     ),

  //     child: SizedBox(
  //       width: 40,
  //       child: Center(
  //         child: Text(code,
  //             style: TextStyle(
  //                 fontSize: 10,
  //                 fontWeight: FontWeight.bold,
  //                 color: Theme.of(context).colorScheme.onSecondaryContainer)),
  //       ),
  //     ),
  //   );
  // }
}

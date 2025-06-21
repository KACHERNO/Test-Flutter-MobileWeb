import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'pglist_event.dart';
part 'pglist_state.dart';

class PglistBloc extends Bloc<PglistEvent, PglistState> {
  PglistBloc(BuildContext context) : super(PglistInitial()) {
    on<PglistRebuild>((event, emit) {
      emit(PglistBuilded(event.addCount, event.reverse));
    });
  }
}

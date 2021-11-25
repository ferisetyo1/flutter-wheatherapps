import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class SimpleBlocObserver extends BlocObserver {
  SimpleBlocObserver();

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);

    debugPrint('$event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint('$transition');
  }

  @override
  void onError(BlocBase cubit, Object error, StackTrace stacktrace) {
    super.onError(cubit, error, stacktrace);
    debugPrintStack(label: 'Error $error', stackTrace: stacktrace);
  }

  @override
  void onChange(BlocBase cubit, Change change) {
    super.onChange(cubit, change);
    debugPrint('$cubit, $change');
  }
}

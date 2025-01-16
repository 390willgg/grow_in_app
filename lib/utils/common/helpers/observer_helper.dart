import 'package:bloc/bloc.dart';
import 'package:grow_in_app/main.dart';

class ObserverHelper extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    logger.d("onChange -- Bloc : $bloc --> $change");
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    logger.d("onEvent -- bloc : $bloc --> $event");
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    logger.d("onCreate -- bloc : $bloc");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger.d("onTransition -- bloc : $bloc --> $transition");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    logger.d("onError -- bloc : $bloc --> $error");
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    logger.d("onClose -- bloc : $bloc");
  }
}

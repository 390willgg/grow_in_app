import 'package:bloc/bloc.dart';
import 'package:grow_in_app/main.dart';

class MyObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    logger.d("Bloc : $bloc --> $change");
  }
}

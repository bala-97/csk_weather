

import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_vm.dart';

/// Bloc for home screen
class HomeBloc extends BlocBase<HomeVm>{
  /// Main constructor
  HomeBloc(HomeVm state) : super(state);
}
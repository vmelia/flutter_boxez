import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DragState extends Equatable {

  @override
  List<Object?> get props => [];
}

class DragCubit extends Cubit<DragState> {
  DragCubit(super.initialState);
}

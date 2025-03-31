import 'dart:convert';
import 'package:app/models/item.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'item_event.dart';
import 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemBloc() : super(ItemInitial()) {
    on<FetchItems>(_fetchItems);
  }

  Future<void> _fetchItems(FetchItems event, Emitter<ItemState> emit) async {
    emit(ItemLoading());
/*
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      emit(ItemError('No connection'));
      return;
    }*/
    // try {
    final jsonString = await rootBundle.loadString('assets/json/data.json');
    final jsonData = jsonDecode(jsonString) as List<dynamic>;
    final items = jsonData.map((json) => ItemModel.fromJson(json)).toList();
    emit(ItemLoaded(items));
    /* } catch (e) {
      emit(ItemError(' $e'));
    }*/
  }
}

import 'dart:async';
import 'dart:convert';
import 'package:app/models/item.dart';
import 'package:app/utils/globa.dart';
import 'package:app/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'item_event.dart';
import 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  bool isOnline = true;

  ItemBloc() : super(ItemInitial()) {
    on<FetchItems>(_fetchItems);
  }
  Future<void> _fetchItems(FetchItems event, Emitter<ItemState> emit) async {
    emit(ItemLoading());

    final shared = await SharedPreferences.getInstance();
    try {
      http.Response response = await http
          .get(Uri.parse(AppGlobal.data))
          .timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body)['record'];
        List<ItemModel> data =
            jsonData.map((item) => ItemModel.fromJson(item)).toList();
        shared.setString(AppStorage.data, jsonEncode(data));
        isOnline = true;
        emit(ConnectionStateChanged(isOnline));
        emit(ItemLoaded(data));
        return;
      } else {
        isOnline = true;
        emit(ConnectionStateChanged(isOnline));
        emit(ItemError('Erro: Status ${response.statusCode}'));
      }
    } on TimeoutException {
      isOnline = false;
      emit(ConnectionStateChanged(isOnline));

      Fluttertoast.showToast(
          msg: "No internet",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      emit(ItemError('No internet'));
    } catch (e) {
      isOnline = false;
      emit(ConnectionStateChanged(isOnline));
      emit(ItemError('Erro: $e'));
    }

    final data = shared.getString(AppStorage.data);
    if (data != null) {
      List<dynamic> decodedData = jsonDecode(data);
      List<ItemModel> items = decodedData
          .map((item) => ItemModel.fromJson(item as Map<String, dynamic>))
          .toList();
      isOnline = true;
      emit(ConnectionStateChanged(isOnline));
      emit(ItemLoaded(items));
    }
  }
}

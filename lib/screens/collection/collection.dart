import 'package:app/bloc/item_event.dart';
import 'package:app/bloc/item_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/bloc/item_bloc.dart';
import 'package:app/screens/collection/widget/card.dart';
import 'package:app/screens/collection/widget/details.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double cardWidth = (screenWidth / 2) - 24;
    double cardHeight = (screenHeight / 3) - 20;

    return BlocProvider(
      create: (_) => ItemBloc()..add(FetchItems()),
      child: Scaffold(
        backgroundColor: const Color(0xff0B1519),
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none,
                color: Colors.white60,
                size: 32,
              ),
            ),
          ],
          title: Column(
            children: [
              Text(
                "My collection",
                style: GoogleFonts.ebGaramond(
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
              BlocBuilder<ItemBloc, ItemState>(
                builder: (context, state) {
                  bool isConnected = true;

                  if (state is ConnectionStateChanged) {
                    isConnected = state.isOnline;
                  }

                  return !isConnected
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 0),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(15)),
                          child: const Text(
                            "No internet",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : const SizedBox();
                },
              )
            ],
          ),
        ),
        body: BlocBuilder<ItemBloc, ItemState>(
          builder: (context, state) {
            if (state is ItemLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ItemLoaded) {
              final bottles = state.items;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  itemCount: bottles.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: cardWidth / cardHeight,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final bottle = bottles[index];
                    return GestureDetector(
                      onTap: () {
                        showBarModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            color: Colors.black,
                            height: screenHeight * 0.9,
                            padding: const EdgeInsets.all(16),
                            child: Details(wines: bottle, index: index),
                          ),
                        );
                      },
                      child: CollectionCard(
                        index: index,
                        name: bottle.name ?? "",
                        image: bottle.image ?? "",
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

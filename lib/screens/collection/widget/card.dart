import 'package:app/utils/colors.dart';
import 'package:flutter/material.dart';

class CollectionCard extends StatefulWidget {
  const CollectionCard(
      {super.key,
      required this.name,
      required this.image,
      required this.index});
  final String name;
  final String image;
  final int index;
  @override
  State<CollectionCard> createState() => _CollectionCardState();
}

class _CollectionCardState extends State<CollectionCard>
    with SingleTickerProviderStateMixin {
  /* late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();

    _animation = Tween<double>(begin: 50, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
*/

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: screenWidth,
      height: screenHeight,
      child: Stack(
        clipBehavior: Clip.none, // Permite a imagem "sair" do card
        children: [
          Container(
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: '${widget.image}${widget.index}',
                  child: Image.asset(
                    widget.image,
                    height: 160,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      widget.name.split("#")[0],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                        fontFamily: 'EB Garamond',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "#${widget.name.split("#")[1]}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
